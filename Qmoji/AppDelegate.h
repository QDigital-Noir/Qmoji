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
@property (nonatomic, assign) BOOL unlockedAnimals;
@property (nonatomic, assign) BOOL unlockedDinosaur;
@property (nonatomic, assign) BOOL unlockedHaunted;
@property (nonatomic, assign) BOOL unlockedMotherNature;
@property (nonatomic, assign) BOOL unlockedSciFi;
@property (nonatomic, assign) BOOL unlockedSeaCreatures;
@property (nonatomic, assign) BOOL unlockedWar;
@property (nonatomic, assign) BOOL unlockedZombie;
@property (nonatomic, assign) BOOL isFromStickers;

+ (AppDelegate *)mainDelegate;
- (void)setFirstView;
- (void)setCateViewWithName:(NSString *)cateName;
- (void)setCollectionView;

@end

