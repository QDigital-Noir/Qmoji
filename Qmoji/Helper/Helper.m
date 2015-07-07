//
//  Helper.m
//  Qmoji
//
//  Created by Q on 4/26/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "Helper.h"
#import "Reachability.h"

@implementation Helper

+ (instancetype)sharedHelper
{
    static Helper *_sharedHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHelper = [[Helper alloc] init];
    });
    
    return _sharedHelper;
}

- (NSArray *)getStickerCategory
{
    // Read plist from bundle and get Root Dictionary out of it
    NSDictionary *dictRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StickerList" ofType:@"plist"]];
    
    return [[dictRoot allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (NSArray *)getStickerListWithKey:(NSString *)key
{
    // Read plist from bundle and get Root Dictionary out of it
    NSDictionary *dictRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StickerList" ofType:@"plist"]];
    
    return (NSArray *)[dictRoot objectForKey:key];
}

- (NSString *)getClientKeyWithKey:(NSString *)key
{
    NSDictionary *dictRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"]];
    
    return dictRoot[key];
}

- (NSString *)getIAPIdentifierWithKey:(NSString *)key
{
    NSDictionary *dictRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"]];
    
    return dictRoot[@"IAP"][key];
}

#pragma mark - Update user default

- (void)updateUnlockedSticker:(BOOL)unlocked withKey:(NSString *)key
{
    NSUserDefaults *appDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.intencemedia.animatedgifkeyboard"];
    [appDefault setObject:[NSNumber numberWithBool:unlocked] forKey:key];
}

- (BOOL)getUnlockedStickerWithKey:(NSString *)key
{
    NSString *iapKey = [NSString stringWithFormat:@"%@_IAP", key];
    NSUserDefaults *appDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.intencemedia.animatedgifkeyboard"];
    NSLog(@"%@",[appDefault objectForKey:iapKey]);
    
    BOOL isUnlock = [[appDefault objectForKey:iapKey] boolValue];
    return isUnlock;
}

#pragma mark - Update user's collections

- (void)updateUserCollectionWithArray:(NSMutableArray *)collectionArray
{
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.intencemedia.animatedgifkeyboard"];
    [userDefault setObject:collectionArray forKey:@"UserCollection"];
}

- (NSArray *)getUserCollection
{
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.intencemedia.animatedgifkeyboard"];
    NSArray *collectionArray = [NSArray arrayWithArray:(NSArray *)[userDefault objectForKey:@"UserCollection"]];
                                return collectionArray;
}

- (void)updateRecentUsedWithArray:(NSMutableArray *)collectionArray
{
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.intencemedia.animatedgifkeyboard"];
    [userDefault setObject:collectionArray forKey:@"RecentUsed"];
}

- (NSArray *)getRecentUsed
{
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.intencemedia.animatedgifkeyboard"];
    NSArray *collectionArray = [NSArray arrayWithArray:(NSArray *)[userDefault objectForKey:@"RecentUsed"]];
    return collectionArray;
}

- (void)setCategoryData:(NSString *)categoryName withArray:(NSArray *)array
{
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.intencemedia.animatedgifkeyboard"];
    [userDefault setObject:array forKey:categoryName];
    NSLog(@"Done : %@",categoryName);
}

- (NSArray *)getCategoryData:(NSString *)categoryName
{
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.intencemedia.animatedgifkeyboard"];
    NSArray *array = [NSArray arrayWithArray:(NSArray *)[userDefault objectForKey:categoryName]];
    return array;
}

- (void)setupDataWithCategoryName:(NSString *)catename
{
    PFQuery *query = [PFQuery queryWithClassName:@"Giphy"];
    [query whereKey:@"category" equalTo:catename];
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
                    NSMutableArray *tempArray = [NSMutableArray array];
                    for (PFObject *obj in objects)
                    {
                        NSDictionary *dict = @{@"giphyFixedWidth" : obj[@"giphyFixedWidth"],
                                               @"giphyOriginal" : obj[@"giphyOriginal"],
                                               @"giphyID" : obj[@"giphyID"],
                                               @"isLock" : obj[@"isLock"],
                                               @"category" : obj[@"category"]};
                        [tempArray addObject:dict];
                    }
                    
                    [[Helper sharedHelper] setCategoryData:catename withArray:tempArray];
                }
                else
                {
                    // success but not found
                }
            }
            else
            {
                // error
            }
        }
        else
        {
            //error
        }
    }];
}

- (void)setupOfflineWithCategoryName:(NSString *)catename
{
    NSDictionary *dictRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"]];
    
    NSArray *dataArray = (NSArray *)dictRoot[@"Offline"][catename];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < dataArray.count; i++)
    {
        NSString *objIDString = (NSString *)dataArray[i];
        BOOL isLock;
        if (i < 10)
        {
            isLock = NO;
        }
        else
        {
            isLock = YES;
        }
        
        NSDictionary *dict = @{@"giphyFixedWidth" : [NSString stringWithFormat:@"%@.gif", objIDString],
                               @"giphyOriginal" : [NSString stringWithFormat:@"%@.gif", objIDString],
                               @"giphyID" : objIDString,
                               @"isLock" : [NSNumber numberWithBool:isLock],
                               @"category" : catename};
        [tempArray addObject:dict];
    }
    
    [[Helper sharedHelper] setCategoryData:catename withArray:tempArray];

}

#pragma mark - Write files.

- (void)writeImageFileWithName:(NSString *)name andImageData:(NSData *)data
{
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory, name];
    
    //save content to the documents directory
    [data writeToFile:fileName atomically:YES];
}

#pragma mark - Network Connectivity

- (BOOL)connectedToNetwork
{
    Reachability* reachability = [Reachability reachabilityWithHostName:@"google.com"];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    BOOL isInternet;
    
    if(remoteHostStatus == NotReachable)
    {
        isInternet =NO;
    }
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        isInternet = TRUE;
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    { isInternet = TRUE;
        
    }
    return isInternet;
}

#pragma mark - Setup Userdefault

- (void)setupInitialData
{
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
}

- (void)setupInitialOfflineData
{
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.intencemedia.animatedgifkeyboard"];
    if ([userDefault objectForKey:@"FIRST_INSTALL_OFFLINE"] == nil)
    {
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Feels"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Sleep"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Happy"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Sad"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Hungry"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Food"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Dance"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Dog"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Cat"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Celebrity"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Drunk"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Tired"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Bored"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Confused"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Mind Blown"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Beer"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Love"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Cars"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Deal With It"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Reaction"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Emotion"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Party"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Cry"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Laugh"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Awkward"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Face palm"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Birthday"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"LOL"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Kiss"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Roll eyes"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Thumbs up"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Thumbs down"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Shrug"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"Wink"];
        [[Helper sharedHelper] setupOfflineWithCategoryName:@"High Five"];
        
        
        [userDefault setObject:[NSNumber numberWithBool:YES] forKey:@"FIRST_INSTALL_OFFLINE"];
        NSLog(@"First install offline");
        
    }
    else
    {
        NSLog(@"ALready install");
    }
}

@end
