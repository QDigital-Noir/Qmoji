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

@interface AppDelegate () <EAIntroDelegate>
{
    MenuViewController *menuVC;
    CategoryViewController *categoryVC;
    CollectionViewController *collectionVC;
    UINavigationController *navMain;
    UIView *rootView;
    EAIntroView *_intro;
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
    
    // IAP
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.all"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedAll = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedAll
                                                                         withKey:@"All_IAP"];
                                    NSLog(@"unlockedAll");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.highfive"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedHighFive = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedHighFive
                                                                         withKey:@"High Five_IAP"];
                                    NSLog(@"unlockedHighFive");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.wink"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedWink = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedWink
                                                                         withKey:@"Wink_IAP"];
                                    NSLog(@"unlockedWink");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.shrug"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedShrug = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedShrug
                                                                         withKey:@"Shrug_IAP"];
                                    NSLog(@"unlockedShrug");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.thumbdown"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedThumbsdown = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedThumbsdown
                                                                         withKey:@"Thumbs down_IAP"];
                                    NSLog(@"unlockedThumbsdown");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.thumbup"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedThumbsup = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedThumbsup
                                                                         withKey:@"Thumbs up_IAP"];
                                    NSLog(@"unlockedThumbsup");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.rolleyes"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedRolleyes = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedRolleyes
                                                                         withKey:@"Roll eyes_IAP"];
                                    NSLog(@"unlockedRolleyes");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.kiss"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedKiss = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedKiss
                                                                         withKey:@"Kiss_IAP"];
                                    NSLog(@"unlockedKiss");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.lol"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedLOL = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedLOL
                                                                         withKey:@"LOL_IAP"];
                                    NSLog(@"unlockedLOL");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.birthday"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedBirthday = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedBirthday
                                                                         withKey:@"Birthday_IAP"];
                                    NSLog(@"unlockedBirthday");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.facepalm"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedFacepalm = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedFacepalm
                                                                         withKey:@"Face palm_IAP"];
                                    NSLog(@"unlockedFacepalm");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.awkward"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedAwkward = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedAwkward
                                                                         withKey:@"Awkward_IAP"];
                                    NSLog(@"unlockedAwkward");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.laugh"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedLaugh = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedLaugh
                                                                         withKey:@"Laugh_IAP"];
                                    NSLog(@"unlockedLaugh");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.cry"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedCry = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedCry
                                                                         withKey:@"Cry_IAP"];
                                    NSLog(@"unlockedCry");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.party"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedParty = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedParty
                                                                         withKey:@"Party_IAP"];
                                    NSLog(@"unlockedParty");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.emotion"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedEmotion = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedEmotion
                                                                         withKey:@"Emotion_IAP"];
                                    NSLog(@"unlockedEmotion");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.reaction"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedReaction = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedReaction
                                                                         withKey:@"Reaction_IAP"];
                                    NSLog(@"unlockedReaction");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.dealwithit"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedDealWithIt = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedDealWithIt
                                                                         withKey:@"Deal With It_IAP"];
                                    NSLog(@"unlockedDealWithIt");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.cars"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedCars = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedCars
                                                                         withKey:@"Cars_IAP"];
                                    NSLog(@"unlockedCars");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.love"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedLove = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedLove
                                                                         withKey:@"Love_IAP"];
                                    NSLog(@"unlockedLove");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.beer"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedBeer = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedBeer
                                                                         withKey:@"Beer_IAP"];
                                    NSLog(@"unlockedBeer");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.mindblown"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedMindBlown = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedMindBlown
                                                                         withKey:@"Mind Blown_IAP"];
                                    NSLog(@"unlockedMindBlown");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.confused"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedConfused = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedConfused
                                                                         withKey:@"Confused_IAP"];
                                    NSLog(@"unlockedConfused");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.bored"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedBored = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedBored
                                                                         withKey:@"Bored_IAP"];
                                    NSLog(@"unlockedBored");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.tired"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedTired = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedTired
                                                                         withKey:@"Tired_IAP"];
                                    NSLog(@"unlockedTired");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.drunk"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedDrunk = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedDrunk
                                                                         withKey:@"Drunk_IAP"];
                                    NSLog(@"unlockedDrunk");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.celebrity"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedCelebrity = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedCelebrity
                                                                         withKey:@"Celebrity_IAP"];
                                    NSLog(@"unlockedCelebrity");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.cat"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedCat = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedCat
                                                                         withKey:@"Cat_IAP"];
                                    NSLog(@"unlockedCat");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.dog"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedDog = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedDog
                                                                         withKey:@"Dog_IAP"];
                                    NSLog(@"unlockedDog");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.dance"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedDance = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedDance
                                                                         withKey:@"Dance_IAP"];
                                    NSLog(@"unlockedDance");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.food"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedFood = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedFood
                                                                         withKey:@"Food_IAP"];
                                    NSLog(@"unlockedFood");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.hungry"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedHungry = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedHungry
                                                                         withKey:@"Hungry_IAP"];
                                    NSLog(@"unlockedHungry");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.sad"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedSad = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedSad
                                                                         withKey:@"Sad_IAP"];
                                    NSLog(@"unlockedSad");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.happy"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedHappy = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedHappy
                                                                         withKey:@"Happy_IAP"];
                                    NSLog(@"unlockedHappy");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.sleep"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedSleep = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedSleep
                                                                         withKey:@"Sleep_IAP"];
                                    NSLog(@"unlockedSleep");
                                    [KVNProgress dismiss];
                                }];
    [PFPurchase addObserverForProduct:@"com.intencemedia.animatedgifkeyboard.feels"
                                block:^(SKPaymentTransaction *transaction) {
                                    self.unlockedFeels = YES;
                                    [[Helper sharedHelper] updateUnlockedSticker:self.unlockedFeels
                                                                         withKey:@"Feels_IAP"];
                                    NSLog(@"unlockedFeels");
                                    [KVNProgress dismiss];
                                }];
    

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
    rootView = navMain.view;
    
    self.slideMenuVC.menuViewController = menuVC;
    self.slideMenuVC.mainViewController = navMain;
    self.slideMenuVC.backgroundImage = [UIImage imageNamed:@"cloud"];
    self.slideMenuVC.backgroundImageContentMode = UIViewContentModeTopLeft;
    self.slideMenuVC.enablePan = NO;
    [self.window setRootViewController:self.slideMenuVC];
    [self.window makeKeyAndVisible];
    
    AppDelegateAccessor.categoryName = @"Feels";
    
    // Setup data
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.intencemedia.animatedgifkeyboard"];
    if ([userDefault objectForKey:@"FIRST_INSTALL"] == nil)
    {
        [[Helper sharedHelper] setupDataWithCategoryName:@"Feels"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Sleep"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Happy"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Sad"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Hungry"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Food"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Dance"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Dog"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Cat"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Celebrity"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Drunk"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Tired"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Bored"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Confused"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Mind Blown"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Beer"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Love"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Cars"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Deal With It"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Reaction"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Emotion"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Party"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Cry"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Laugh"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Awkward"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Face palm"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Birthday"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"LOL"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Kiss"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Roll eyes"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Thumbs up"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Thumbs down"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Shrug"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"Wink"];
        [[Helper sharedHelper] setupDataWithCategoryName:@"High Five"];
        
        
        [userDefault setObject:[NSNumber numberWithBool:YES] forKey:@"FIRST_INSTALL"];
        NSLog(@"First install");
        
    }
    else
    {
        NSLog(@"ALready install");
    }
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"";
    page1.desc = @"";
    page1.bgImage = [UIImage imageNamed:@"Screenshot1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title1"]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"";
    page2.desc = @"";
    page2.bgImage = [UIImage imageNamed:@"Screenshot2"];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title2"]];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"";
    page3.desc = @"";
    page3.bgImage = [UIImage imageNamed:@"Screenshot3"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title3"]];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"";
    page4.desc = @"";
    page4.bgImage = [UIImage imageNamed:@"Screenshot4"];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title4"]];
    
    EAIntroPage *page5 = [EAIntroPage page];
    page5.title = @"";
    page5.desc = @"";
    page5.bgImage = [UIImage imageNamed:@"Screenshot5"];
    page5.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title4"]];
    
    EAIntroPage *page6 = [EAIntroPage page];
    page6.title = @"";
    page6.desc = @"";
    page6.bgImage = [UIImage imageNamed:@"Screenshot6"];
    page6.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title4"]];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[page1,page2,page3,page4,page5,page6]];
    [intro setDelegate:self];
    [intro showInView:rootView animateDuration:0.3];
    
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

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    // Check the calling application Bundle ID
    if (url != nil)
    {
        NSLog(@"URL scheme: %@", [url scheme]);
        NSLog(@"URL query: %@", [url query]);
        NSArray *array = [[url query] componentsSeparatedByString:@"="];
        NSLog(@"%@ : %@", array[0], array[1]);
        AppDelegateAccessor.categoryName = array[1];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"REDIRECT_CATEGORY" object:nil];
        return YES;
    }
    else
        return NO;
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
