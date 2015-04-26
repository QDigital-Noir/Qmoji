//
//  GiphyObj.h
//  Qmoji
//
//  Created by Q on 4/26/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiphyObj : NSObject

@property (nonatomic, strong) NSString *giphyID;
@property (nonatomic, strong) NSString *giphyOriginal;
@property (nonatomic, strong) NSString *giphyFixedWidth;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+ (NSURLSessionDataTask *)searchGiphyWitKeyword:(NSString *)keyword
                                      withBlock:(void (^)(NSArray *posts, NSError *error))block;
+ (NSURLSessionDataTask *)trendingGiphyWithBlock:(void (^)(NSArray *posts, NSError *error))block;

@end
