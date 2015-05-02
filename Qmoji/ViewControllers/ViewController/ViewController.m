//
//  ViewController.m
//  Qmoji
//
//  Created by Q on 4/24/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "MainCollectionViewCell.h"
#import "UIRefreshControl+AFNetworking.h"
#import "UIAlertView+AFNetworking.h"

#define kCellsPerRow 2

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableArray *resultArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configView];
    [self reload:nil];
    self.title = @"Trending";

//    for (NSString* family in [UIFont familyNames])
//    {
//        NSLog(@"%@", family);
//        
//        for (NSString* name in [UIFont fontNamesForFamilyName: family])
//        {
//            NSLog(@"  %@", name);
//        }
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    self.navigationItem.rightBarButtonItem.enabled = NO;
//    NSURLSessionTask *task = [GiphyObj trendingGiphyWithBlock:^(NSArray *posts, NSError *error) {
//        if (!error && posts.count != 0)
//        {
//            self.gifArray = [NSArray arrayWithArray:posts];
////            [self.gifCollectionVIew reloadData];
//            
////            for (GiphyObj *gifObj in self.gifArray)
////            {
////                PFObject *obj = [PFObject objectWithClassName:@"Giphy"];
////                [obj setObject:gifObj.giphyID forKey:@"giphyID"];
////                [obj setObject:gifObj.giphyFixedWidth forKey:@"giphyFixedWidth"];
////                [obj setObject:gifObj.giphyOriginal forKey:@"giphyOriginal"];
////                [obj setObject:@"Trending" forKey:@"category"];
////                [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
////                    if (succeeded)
////                    {
////                        //Success
////                        NSLog(@"----- SAVE -----");
////                    }
////                    else
////                    {
////                        //Error Save Failed
////                    }
////                }];
////            }
//        }
//        else
//        {
//            
//        }
//    }];
//    
//    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
//    [self.refreshControl setRefreshingWithStateOfTask:task];
    
    KVNProgressConfiguration *basicConfiguration = [[KVNProgressConfiguration alloc] init];;
    basicConfiguration.backgroundType = KVNProgressBackgroundTypeSolid;
    basicConfiguration.fullScreen = YES;
    [KVNProgress showWithStatus:@"Loading..."];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Giphy"];
    [query whereKey:@"category" equalTo:@"Trending"];
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
                    [self.refreshControl endRefreshing];
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
    AppDelegateAccessor.isFromTrendingScreen = YES;
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
    MainCollectionViewCell *cell = (MainCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    PFObject *obj = (PFObject *)self.gifArray[indexPath.row];
    
    [cell setImageWithURL:obj[@"giphyFixedWidth"]
                andIsPaid:@NO
              andCateName:@"Test"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KVNProgressConfiguration *basicConfiguration = [[KVNProgressConfiguration alloc] init];;
    basicConfiguration.backgroundType = KVNProgressBackgroundTypeSolid;
    basicConfiguration.fullScreen = YES;
    
    // Update user collection.
    PFObject *obj = (PFObject *)self.gifArray[indexPath.row];
    NSMutableArray *collectionArray = [NSMutableArray arrayWithArray:[[Helper sharedHelper] getUserCollection]];
    NSDictionary *tempDict = @{@"giphyID" : obj[@"giphyID"],
                               @"giphyOriginal" : obj[@"giphyOriginal"],
                               @"giphyFixedWidth" : obj[@"giphyFixedWidth"]};
    
    // Check if already exist
    for (NSDictionary *dict in collectionArray)
    {
        if ([dict[@"giphyID"] isEqualToString:obj[@"giphyID"]])
        {
            [KVNProgress showErrorWithStatus:@"Already existing in your collection"];
            return;
        }
    }
    
    [collectionArray addObject:tempDict];
    [[Helper sharedHelper] updateUserCollectionWithArray:collectionArray];
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

#pragma mark - TextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *searchText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self filterContentForSearchText:searchText scope:nil];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Filtering SearchResult

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
{
//    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"beerName CONTAINS[c] %@", searchText];
//    self.resultArray = [[self.allListArray objectsWithPredicate:resultPredicate] arraySortedByProperty:@"beerName" ascending:YES];
//    
//    if ((self.resultArray.count == 0) && (searchText.length <= 0))
//    {
//        self.resultArray = self.allListArray;
//    }
//    
//    [self.beerCollectionView reloadData];
//    [self.beerCollectionView reloadItemsAtIndexPaths:[self.beerCollectionView indexPathsForVisibleItems]];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    NSURLSessionTask *task = [GiphyObj searchGiphyWitKeyword:searchText withBlock:^(NSArray *posts, NSError *error) {
        if (!error)
        {
            self.gifArray = [NSArray arrayWithArray:posts];
            [self.gifCollectionVIew reloadData];
        }
        else
        {
            
        }
    }];
    
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    [self.refreshControl setRefreshingWithStateOfTask:task];
}
@end
