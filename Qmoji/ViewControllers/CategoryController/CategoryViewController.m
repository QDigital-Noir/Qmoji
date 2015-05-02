//
//  CategoryViewController.m
//  Qmoji
//
//  Created by Q on 4/27/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "CategoryViewController.h"
#import "AppDelegate.h"
#import "CategoryCollectionViewCell.h"
#import "UIRefreshControl+AFNetworking.h"
#import "UIAlertView+AFNetworking.h"

#define kCellsPerRow 2

@interface CategoryViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation CategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (AppDelegateAccessor.isFromTrendingScreen)
    {
        [self reload:nil];
    }
    
    if (AppDelegateAccessor.isFromCollectionScreen)
    {
        [self reload:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    // Add notification observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"CHANGED_CATEGORY" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Setup view.

- (void)configView
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
    [self.gifCollectionVIew addSubview:self.refreshControl];
    self.gifCollectionVIew.alwaysBounceVertical = YES;
}

#pragma mark - Data Methods

- (void)reload:(__unused id)sender
{
    KVNProgressConfiguration *basicConfiguration = [[KVNProgressConfiguration alloc] init];;
    basicConfiguration.backgroundType = KVNProgressBackgroundTypeSolid;
    basicConfiguration.fullScreen = YES;
    [KVNProgress showWithStatus:@"Loading..."];
    
    if (self.gifArray != nil && self.gifArray.count > 0)
    {
        self.gifArray = nil;
        [self.gifCollectionVIew reloadData];
    }
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
//    NSURLSessionTask *task = [GiphyObj searchGiphyWitKeyword:AppDelegateAccessor.categoryName withBlock:^(NSArray *posts, NSError *error) {
//        if (!error && posts.count != 0)
//        {
//            NSLog(@"Found %@ : %lu", AppDelegateAccessor.categoryName, (unsigned long)posts.count);
//            self.gifArray = [NSArray arrayWithArray:posts];
//            [self.gifCollectionVIew reloadData];
//            [KVNProgress dismiss];
//        }
//        else
//        {
//            // Redirect back to trending screen.
//            [[AppDelegate mainDelegate] setFirstView];
//        }
//    }];
//    
//    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
//    [self.refreshControl setRefreshingWithStateOfTask:task];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Giphy"];
    [query whereKey:@"category" equalTo:AppDelegateAccessor.categoryName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            //success
            if (!error)
            {
                if (objects != nil && objects.count != 0)
                {
                    // success
                    self.gifArray = [NSArray arrayWithArray:objects];
                    [self.gifCollectionVIew reloadData];
                    [KVNProgress dismiss];
                }
                else
                {
                    // success but not found
                    NSLog(@"No data found");
                    [KVNProgress dismiss];
                }
            }
            else
            {
                // error
                NSLog(@"Error");
                [KVNProgress dismiss];
            }
        }
        else
        {
            //error
            NSLog(@"Error");
            [KVNProgress dismiss];
        }
    }];
}

#pragma mark - Button Methods
- (IBAction)menuAction:(id)sender
{
    AppDelegateAccessor.isFromCollectionScreen = NO;
    AppDelegateAccessor.isFromTrendingScreen = NO;
    [[AppDelegate mainDelegate].slideMenuVC toggleMenu];
}

#pragma mark - UICollectionView DataSource & Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.gifArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    CategoryCollectionViewCell *cell = (CategoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    PFObject *obj = (PFObject *)self.gifArray[indexPath.row];
    
    [cell setImageWithURL:obj[@"giphyFixedWidth"]
                andIsPaid:@NO
              andCateName:@"Test"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Update user collection.
    PFObject *obj = (PFObject *)self.gifArray[indexPath.row];
    NSMutableArray *collectionArray = [NSMutableArray arrayWithArray:[[Helper sharedHelper] getUserCollection]];
    NSDictionary *tempDict = @{@"giphyID" : obj[@"giphyID"],
                               @"giphyOriginal" : obj[@"giphyOriginal"],
                               @"giphyFixedWidth" : obj[@"giphyFixedWidth"]};
    [collectionArray addObject:tempDict];
    [[Helper sharedHelper] updateUserCollectionWithArray:collectionArray];
    
    KVNProgressConfiguration *basicConfiguration = [[KVNProgressConfiguration alloc] init];;
    basicConfiguration.backgroundType = KVNProgressBackgroundTypeSolid;
    basicConfiguration.fullScreen = YES;
    [KVNProgress showSuccessWithStatus:@"Added to your collection"];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.gifCollectionVIew.collectionViewLayout;
    CGFloat availableWidthForCells = CGRectGetWidth(self.gifCollectionVIew.frame) - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing * (kCellsPerRow - 1);
    CGFloat cellWidth = availableWidthForCells / kCellsPerRow;
    flowLayout.itemSize = CGSizeMake(cellWidth, flowLayout.itemSize.height);
    return flowLayout.itemSize;
}

//#pragma mark - TextField Delegate
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSString *searchText = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    [self filterContentForSearchText:searchText scope:nil];
//    
//    return YES;
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}
//
//#pragma mark - Filtering SearchResult
//
//- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
//{
//    self.navigationItem.rightBarButtonItem.enabled = NO;
//    NSURLSessionTask *task = [GiphyObj searchGiphyWitKeyword:searchText withBlock:^(NSArray *posts, NSError *error) {
//        if (!error)
//        {
//            self.gifArray = [NSArray arrayWithArray:posts];
//            [self.gifCollectionVIew reloadData];
//        }
//        else
//        {
//            
//        }
//    }];
//    
//    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
//    [self.refreshControl setRefreshingWithStateOfTask:task];
//}
@end
