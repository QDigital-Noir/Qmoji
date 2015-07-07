//
//  Helper.h
//  Qmoji
//
//  Created by Q on 4/26/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

+ (instancetype)sharedHelper;
- (NSArray *)getStickerCategory;
- (NSArray *)getStickerListWithKey:(NSString *)key;
- (NSString *)getClientKeyWithKey:(NSString *)key;
- (NSString *)getIAPIdentifierWithKey:(NSString *)key;
- (void)updateUnlockedSticker:(BOOL)unlocked withKey:(NSString *)key;
- (BOOL)getUnlockedStickerWithKey:(NSString *)key;
- (void)updateUserCollectionWithArray:(NSMutableArray *)collectionArray;
- (NSArray *)getUserCollection;
- (void)writeImageFileWithName:(NSString *)name andImageData:(NSData *)data;
- (void)setCategoryData:(NSString *)categoryName withArray:(NSArray *)array;
- (NSArray *)getCategoryData:(NSString *)categoryName;
- (void)setupDataWithCategoryName:(NSString *)catename;
- (void)updateRecentUsedWithArray:(NSMutableArray *)collectionArray;
- (NSArray *)getRecentUsed;
- (BOOL)connectedToNetwork;
- (void)setupInitialData;
- (void)setupOfflineWithCategoryName:(NSString *)catename;
- (void)setupInitialOfflineData;
@end
