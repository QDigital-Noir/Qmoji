//
//  Helper.m
//  Qmoji
//
//  Created by Q on 4/26/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "Helper.h"

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

@end
