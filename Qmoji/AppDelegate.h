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

+ (AppDelegate *)mainDelegate;
- (void)setFirstView;
//- (void)setSecondView;

@end

