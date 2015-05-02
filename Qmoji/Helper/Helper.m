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
    [appDefault synchronize];
}

- (BOOL)getUnlockedStickerWithKey:(NSString *)key
{
    NSUserDefaults *appDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.intencemedia.animatedgifkeyboard"];
    BOOL isUnlock = [[appDefault objectForKey:key] boolValue];
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
