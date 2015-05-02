//
//  GiphyObj.m
//  Qmoji
//
//  Created by Q on 4/26/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "GiphyObj.h"

@implementation GiphyObj

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.giphyID = [attributes valueForKeyPath:@"id"];
    self.giphyOriginal = attributes[@"images"][@"original"][@"url"];
    self.giphyFixedWidth = attributes[@"images"][@"fixed_width_downsampled"][@"url"];
    
    return self;
}

+ (NSURLSessionDataTask *)searchGiphyWitKeyword:(NSString *)keyword
                                      withBlock:(void (^)(NSArray *posts, NSError *error))block
{
    
    NSString *searchPath = [NSString stringWithFormat:@"/v1/gifs/search"];
    NSString *searchKey = [searchPath stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    return [[APIClientHelper sharedClient] GET:searchKey
                                    parameters:@{@"q": keyword,
                                                 @"api_key" : @GiphyPublicKey}
                                       success:^(NSURLSessionDataTask * __unused task, id JSON) {
                                           NSArray *postsFromResponse = [JSON valueForKeyPath:@"data"];
                                           NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
                                           for (NSDictionary *attributes in postsFromResponse)
                                           {
                                               GiphyObj *giphyObj = [[GiphyObj alloc] initWithAttributes:attributes];
                                               [mutablePosts addObject:giphyObj];
                                           }
                                           
                                           if (block)
                                           {
                                               block([NSArray arrayWithArray:mutablePosts], nil);
                                           }
                                       } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
                                           if (block)
                                           {
                                               block([NSArray array], error);
                                           }
                                       }];
}

+ (NSURLSessionDataTask *)trendingGiphyWithBlock:(void (^)(NSArray *posts, NSError *error))block
{
    
    NSString *searchPath = [NSString stringWithFormat:@"/v1/gifs/trending"];
    NSString *searchKey = [searchPath stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    return [[APIClientHelper sharedClient] GET:searchKey
                                    parameters:@{@"api_key" : @GiphyPublicKey}
                                       success:^(NSURLSessionDataTask * __unused task, id JSON) {
                                           NSArray *postsFromResponse = [JSON valueForKeyPath:@"data"];
                                           NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
                                           for (NSDictionary *attributes in postsFromResponse)
                                           {
                                               GiphyObj *giphyObj = [[GiphyObj alloc] initWithAttributes:attributes];
                                               [mutablePosts addObject:giphyObj];
                                           }
                                           
                                           if (block)
                                           {
                                               block([NSArray arrayWithArray:mutablePosts], nil);
                                           }
                                       } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
                                           if (block)
                                           {
                                               block([NSArray array], error);
                                           }
                                       }];
}

@end
