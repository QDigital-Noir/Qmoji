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
@property (nonatomic, assign) BOOL unlockedTrending;
@property (nonatomic, assign) BOOL unlockedAnimals;
@property (nonatomic, assign) BOOL unlockedSciFi;
@property (nonatomic, assign) BOOL unlockedMovies;
@property (nonatomic, assign) BOOL unlockedFunnies;
@property (nonatomic, assign) BOOL unlockedMeme;
@property (nonatomic, assign) BOOL unlockedCartoons;
@property (nonatomic, assign) BOOL unlockedZombie;
@property (nonatomic, assign) BOOL unlockedLove;
@property (nonatomic, assign) BOOL isFromStickers;
@property (nonatomic, assign) BOOL isFromCollectionScreen;
@property (nonatomic, assign) BOOL isFromTrendingScreen;
@property (nonatomic, strong) NSString *categoryName;

+ (AppDelegate *)mainDelegate;
- (void)setFirstView;
- (void)setCateView;
- (void)setCollectionView;

@end

