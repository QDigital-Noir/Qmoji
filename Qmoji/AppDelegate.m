//
//  AppDelegate.m
//  Qmoji
//
//  Created by Q on 4/24/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"
#import "ViewController.h"
#import "CategoryViewController.h"
#import "CollectionViewController.h"
#import <Crashlytics/Crashlytics.h>


@interface AppDelegate ()
{
    MenuViewController *menuVC;
    CategoryViewController *categoryVC;
    CollectionViewController *collectionVC;
    UINavigationController *navMain;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Crashlytics startWithAPIKey:@"6cef888a67b2dfb13971b13b469ef3cd1eb79cce"];
    
    // Parse setup
    [Parse setApplicationId:@"VGBTWz7FYeSVcRq12XixARL7nQGOo08EADw92L8a"
                  clientKey:@"CW1d0mJAGTjBhvgLBs1WEay92o9reViZgtP76eZD"];
    
    // Register for Push Notitications
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
    
//    // IAP Setup
//    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.all"
//                                block:^(SKPaymentTransaction *transaction) {
//                                    self.unlockedAll = YES;
//                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedAll
//                                                                         withKey:@"All"];
//                                    NSLog(@"unlockedAll");
//                                    [KVNProgress dismiss];
//                                }];
//    [PFPurchase addObserverForProduct:@"com.intencemedia.moviefxstickers.animals"
//                                block:^(SKPaymentTransaction *transaction) {
//                                    self.unlockedAnimals = YES;
//                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedAnimals
//                                                                         withKey:@"Animals"];
//                                    NSLog(@"unlockedAnimals");
//                                    [KVNProgress dismiss];
//                                }];
//    [PFPurchase addObserverForProduct:@"com.intencemedia.moviefxstickers.dinosaur"
//                                block:^(SKPaymentTransaction *transaction) {
//                                    self.unlockedDinosaur = YES;
//                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedDinosaur
//                                                                         withKey:@"Dinosaur"];
//                                    NSLog(@"unlockedDinosaur");
//                                    [KVNProgress dismiss];
//                                }];
//    [PFPurchase addObserverForProduct:@"com.intencemedia.moviefxstickers.haunted"
//                                block:^(SKPaymentTransaction *transaction) {
//                                    self.unlockedHaunted = YES;
//                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedHaunted
//                                                                         withKey:@"Haunted"];
//                                    NSLog(@"unlockedHaunted");
//                                    [KVNProgress dismiss];
//                                }];
//    [PFPurchase addObserverForProduct:@"com.intencemedia.moviefxstickers.mothernature"
//                                block:^(SKPaymentTransaction *transaction) {
//                                    self.unlockedMotherNature = YES;
//                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedMotherNature
//                                                                         withKey:@"Mother Nature"];
//                                    NSLog(@"unlockedMotherNature");
//                                    [KVNProgress dismiss];
//                                }];
//    [PFPurchase addObserverForProduct:@"com.intencemedia.moviefxstickers.scifi"
//                                block:^(SKPaymentTransaction *transaction) {
//                                    self.unlockedSciFi = YES;
//                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedSciFi
//                                                                         withKey:@"Sci-Fi"];
//                                    NSLog(@"unlockedSciFi");
//                                    [KVNProgress dismiss];
//                                }];
//    [PFPurchase addObserverForProduct:@"com.intencemedia.moviefxstickers.seacreatures"
//                                block:^(SKPaymentTransaction *transaction) {
//                                    self.unlockedSeaCreatures = YES;
//                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedSeaCreatures
//                                                                         withKey:@"Sea Creatures"];
//                                    NSLog(@"unlockedSeaCreatures");
//                                    [KVNProgress dismiss];
//                                }];
//    [PFPurchase addObserverForProduct:@"com.intencemedia.moviefxstickers.war"
//                                block:^(SKPaymentTransaction *transaction) {
//                                    self.unlockedWar = YES;
//                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedWar
//                                                                         withKey:@"War"];
//                                    NSLog(@"unlockedWar");
//                                    [KVNProgress dismiss];
//                                }];
//    [PFPurchase addObserverForProduct:@"com.intencemedia.moviefxstickers.zombie"
//                                block:^(SKPaymentTransaction *transaction) {
//                                    self.unlockedZombie = YES;
//                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedZombie
//                                                                         withKey:@"Zombie"];
//                                    NSLog(@"unlockedZombie");
//                                    [KVNProgress dismiss];
//                                }];

    
    // Setup navigationbar style
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]]; // Set bar button color
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]]; // Set bar background color
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"JosefinSans-Bold" size:26.0], NSFontAttributeName, nil]];
    
    // Setup menu.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.slideMenuVC = [[HKSlideMenu3DController alloc] init];
    self.slideMenuVC.view.frame =  [[UIScreen mainScreen] bounds];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    menuVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    menuVC.view.backgroundColor = [UIColor clearColor];
    navMain = (UINavigationController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"MainNavController"];
    
    self.slideMenuVC.menuViewController = menuVC;
    self.slideMenuVC.mainViewController = navMain;
    self.slideMenuVC.backgroundImage = [UIImage imageNamed:@"cloud"];
    self.slideMenuVC.backgroundImageContentMode = UIViewContentModeTopLeft;
    self.slideMenuVC.enablePan = NO;
    [self.window setRootViewController:self.slideMenuVC];
    [self.window makeKeyAndVisible];
    
    // Setup data
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.intencemedia.animatedgifkeyboard"];
    if ([userDefault objectForKey:@"FIRST_INSTALL"] == nil)
    {
        [[Helper sharedHelper] setupDataWithCategoryName:@"Trending"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Animals"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Sci-Fi"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Movies"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Funnies"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Meme"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Cartoons"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Love"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Zombies"];
        
        [userDefault setObject:[NSNumber numberWithBool:YES] forKey:@"FIRST_INSTALL"];
        NSLog(@"First install");
    }
    else
    {
        NSLog(@"ALready install");
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

+ (AppDelegate *)mainDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)setFirstView
{
    if (!navMain)
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        navMain = (UINavigationController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"ViewController"];
    }
    
    self.slideMenuVC.mainViewController = navMain;
}

- (void)setCateView
{
    if (!categoryVC)
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        categoryVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"CategoryViewController"];
    }
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:categoryVC];
    self.slideMenuVC.mainViewController = navVC;
}

- (void)setCollectionView
{
    if (!collectionVC)
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        collectionVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
    }
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:collectionVC];
    self.slideMenuVC.mainViewController = navVC;
}

@end
