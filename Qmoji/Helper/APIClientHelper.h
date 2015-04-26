//
//  APIClientHelper.h
//  Qmoji
//
//  Created by Q on 4/26/15.
//  Copyright (c) 2015 Q. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface APIClientHelper : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
