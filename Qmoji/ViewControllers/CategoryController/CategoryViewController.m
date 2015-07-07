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
    [self reload:nil];

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"REDIRECT_CATEGORY" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    self.title = AppDelegateAccessor.categoryName;

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
////            self.gifArray = [NSArray arrayWithArray:posts];
////            [self.gifCollectionVIew reloadData];
//            [KVNProgress dismiss];
//            
//            for (GiphyObj *gifObj in posts)
//            {
//                PFObject *obj = [PFObject objectWithClassName:@"Giphy"];
//                [obj setObject:gifObj.giphyID forKey:@"giphyID"];
//                [obj setObject:gifObj.giphyFixedWidth forKey:@"giphyFixedWidth"];
//                [obj setObject:gifObj.giphyOriginal forKey:@"giphyOriginal"];
//                [obj setObject:AppDelegateAccessor.categoryName forKey:@"category"];
//                [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                    if (succeeded)
//                    {
//                        //Success
//                        NSLog(@"----- SAVE -----");
//                    }
//                    else
//                    {
//                        //Error Save Failed
//                    }
//                }];
//            }
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
    
    /*
    PFQuery *query = [PFQuery queryWithClassName:@"Giphy"];
    [query whereKey:@"category" equalTo:AppDelegateAccessor.categoryName];
    [query addDescendingOrder:@"createdAt"];
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
    */
    
    self.gifArray = [NSArray arrayWithArray:[[Helper sharedHelper] getCategoryData:AppDelegateAccessor.categoryName]];
    [self.gifCollectionVIew reloadData];
    [KVNProgress dismiss];
    [self.refreshControl endRefreshing];}

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
                andIsPaid:[obj[@"isLock"] boolValue]
              andCateName:obj[@"category"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *obj = (PFObject *)self.gifArray[indexPath.row];
    
    BOOL isUnlock = [[Helper sharedHelper] getUnlockedStickerWithKey:AppDelegateAccessor.categoryName];
    BOOL isUnlockAll = [[Helper sharedHelper] getUnlockedStickerWithKey:@"All"];
    BOOL isLock = [obj[@"isLock"] boolValue];
    
    if (isUnlock || isUnlockAll)
    {
        NSLog(@"Unlocked %@", AppDelegateAccessor.categoryName);
        KVNProgressConfiguration *basicConfiguration = [[KVNProgressConfiguration alloc] init];;
        basicConfiguration.backgroundType = KVNProgressBackgroundTypeSolid;
        basicConfiguration.fullScreen = YES;
        
        // Update user collection.
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
    else
    {
        if (isLock)
        {
            NSLog(@"Need to unlock!!!!!!");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"GIF Keyboard"
                                                            message:@"Unlock all GIFS in category for $0.99"
                                                           delegate:self
                                                  cancelButtonTitle:@"No, Thank you"
                                                  otherButtonTitles:@"Unlock now!", nil];
            [alert show];
        }
        else
        {
            NSLog(@"No need to unlock");
            KVNProgressConfiguration *basicConfiguration = [[KVNProgressConfiguration alloc] init];;
            basicConfiguration.backgroundType = KVNProgressBackgroundTypeSolid;
            basicConfiguration.fullScreen = YES;
            
            // Update user collection.
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
    }
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

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"Not purchease");
    }
    else
    {
        NSLog(@"Buying : %@", [[Helper sharedHelper] getIAPIdentifierWithKey:AppDelegateAccessor.categoryName]);
        KVNProgressConfiguration *basicConfiguration = [[KVNProgressConfiguration alloc] init];
        basicConfiguration.backgroundType = KVNProgressBackgroundTypeSolid;
        basicConfiguration.fullScreen = YES;
        [KVNProgress showWithStatus:@"Loading..."];
        
        [PFPurchase buyProduct:[[Helper sharedHelper] getIAPIdentifierWithKey:AppDelegateAccessor.categoryName] block:^(NSError *error) {
            if (!error)
            {
                // Run UI logic that informs user the product has been purchased, such as displaying an alert view.
                NSLog(@"Unlock %@ Success", AppDelegateAccessor.categoryName);
                [self.gifCollectionVIew reloadData];
                [KVNProgress dismiss];
            }
            else
            {
                NSLog(@"IAP Error : %@", error.localizedDescription);
                [KVNProgress showErrorWithStatus:@"Error"];
            }
        }];
    }
}

@end
