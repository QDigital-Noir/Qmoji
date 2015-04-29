//
//  CollectionViewController.m
//  Qmoji
//
//  Created by Q on 4/27/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "CollectionViewController.h"
#import "AppDelegate.h"
#import "UserCollectionViewCell.h"
#import "UIRefreshControl+AFNetworking.h"
#import "UIAlertView+AFNetworking.h"

#define kCellsPerRow 2

@interface CollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self reload:nil];
}

- (void)didReceiveMemoryWarning {
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
    self.navigationItem.rightBarButtonItem.enabled = NO;
    NSURLSessionTask *task = [GiphyObj trendingGiphyWithBlock:^(NSArray *posts, NSError *error) {
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

#pragma mark - Button Methods
- (IBAction)menuAction:(id)sender
{
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
    UserCollectionViewCell *cell = (UserCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    GiphyObj *obj = (GiphyObj *)self.gifArray[indexPath.row];
    
    [cell setImageWithURL:obj.giphyFixedWidth
                andIsPaid:@NO
              andCateName:@"Test"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Update user collection.
    GiphyObj *obj = (GiphyObj *)self.gifArray[indexPath.row];
    NSMutableArray *collectionArray = [NSMutableArray arrayWithArray:[[Helper sharedHelper] getUserCollection]];
    NSDictionary *tempDict = @{@"giphyID" : obj.giphyID,
                               @"giphyOriginal" : obj.giphyOriginal,
                               @"giphyFixedWidth" : obj.giphyFixedWidth};
    [collectionArray addObject:tempDict];
    [[Helper sharedHelper] updateUserCollectionWithArray:collectionArray];
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
