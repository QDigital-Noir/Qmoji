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
    self.slideMenuVC.mainViewController = categoryVC;
}

- (void)setCollectionView
{
    if (!collectionVC)
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        collectionVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
    }
    self.slideMenuVC.mainViewController = collectionVC;
}

@end
