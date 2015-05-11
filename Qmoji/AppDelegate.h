//
//  AppDelegate.h
//  Qmoji
//
//  Created by Q on 4/24/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HKSlideMenu3DController.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)  HKSlideMenu3DController *slideMenuVC;
@property (nonatomic, assign) BOOL unlockedAll;
@property (nonatomic, assign) BOOL unlockedFeels;
@property (nonatomic, assign) BOOL unlockedSleep;
@property (nonatomic, assign) BOOL unlockedHappy;
@property (nonatomic, assign) BOOL unlockedSad;
@property (nonatomic, assign) BOOL unlockedHungry;
@property (nonatomic, assign) BOOL unlockedFood;
@property (nonatomic, assign) BOOL unlockedDance;
@property (nonatomic, assign) BOOL unlockedDog;
@property (nonatomic, assign) BOOL unlockedCat;
@property (nonatomic, assign) BOOL unlockedCelebrity;
@property (nonatomic, assign) BOOL unlockedDrunk;
@property (nonatomic, assign) BOOL unlockedTired;
@property (nonatomic, assign) BOOL unlockedBored;
@property (nonatomic, assign) BOOL unlockedConfused;
@property (nonatomic, assign) BOOL unlockedMindBlown;
@property (nonatomic, assign) BOOL unlockedBeer;
@property (nonatomic, assign) BOOL unlockedLove;
@property (nonatomic, assign) BOOL unlockedCars;
@property (nonatomic, assign) BOOL unlockedDealWithIt;
@property (nonatomic, assign) BOOL unlockedReaction;
@property (nonatomic, assign) BOOL unlockedEmotion;
@property (nonatomic, assign) BOOL unlockedParty;
@property (nonatomic, assign) BOOL unlockedCry;
@property (nonatomic, assign) BOOL unlockedLaugh;
@property (nonatomic, assign) BOOL unlockedAwkward;
@property (nonatomic, assign) BOOL unlockedFacepalm;
@property (nonatomic, assign) BOOL unlockedBirthday;
@property (nonatomic, assign) BOOL unlockedLOL;
@property (nonatomic, assign) BOOL unlockedKiss;
@property (nonatomic, assign) BOOL unlockedRolleyes;
@property (nonatomic, assign) BOOL unlockedThumbsup;
@property (nonatomic, assign) BOOL unlockedThumbsdown;
@property (nonatomic, assign) BOOL unlockedShrug;
@property (nonatomic, assign) BOOL unlockedWink;
@property (nonatomic, assign) BOOL unlockedHighFive;
@property (nonatomic, assign) BOOL isFromStickers;
@property (nonatomic, assign) BOOL isFromCollectionScreen;
@property (nonatomic, assign) BOOL isFromTrendingScreen;
@property (nonatomic, strong) NSString *categoryName;

+ (AppDelegate *)mainDelegate;
- (void)setCateView;
- (void)setCollectionView;

@end

