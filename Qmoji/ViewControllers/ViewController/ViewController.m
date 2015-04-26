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

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURLSessionTask *task = [GiphyObj searchGiphyWitKeyword:@"Animal" withBlock:^(NSArray *posts, NSError *error) {
        if (!error)
        {
            GiphyObj *obj = (GiphyObj *)posts[0];
            NSLog(@"giphyID : %@", obj.giphyID);
            NSLog(@"giphyOriginal : %@", obj.giphyOriginal);
            NSLog(@"giphyFixedWidth : %@", obj.giphyFixedWidth);
        }
        else
        {
            
        }
    }];
    
//    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    MainCollectionViewCell *cell = (MainCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    [cell setImageWithURL:self.stickerArray[indexPath.row][@"URL"]
//                andIsPaid:[self.stickerArray[indexPath.row][@"isPaid"] boolValue]
//              andCateName:self.cateName];
//    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    BOOL isUnlock = [[Helper sharedHelper] getUnlockedStickerWithKey:self.cateName];
//    BOOL isUnlockAll = [[Helper sharedHelper] getUnlockedStickerWithKey:@"All"];
//    BOOL isPaid = [self.stickerArray[indexPath.row][@"isPaid"] boolValue];
//    
//    if (isUnlock || isUnlockAll)
//    {
//        NSLog(@"Unlocked %@", self.cateName);
//        StickerCollectionViewCell *cell = (StickerCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//        AppDelegateAccessor.stickerImage = cell.imageView.image;
//        AppDelegateAccessor.isFromStickers = YES;
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    else
//    {
//        if (isPaid)
//        {
//            NSLog(@"Need to unlock!!!!!!");
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Movie FX Stickers"
//                                                            message:@"This stickers need to unlock."
//                                                           delegate:self
//                                                  cancelButtonTitle:@"No, Thank you"
//                                                  otherButtonTitles:@"Unlock now!", nil];
//            [alert show];
//        }
//        else
//        {
//            StickerCollectionViewCell *cell = (StickerCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//            AppDelegateAccessor.stickerImage = cell.imageView.image;
//            AppDelegateAccessor.isFromStickers = YES;
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }
}

@end
