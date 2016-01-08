//
//  StickrNetworkClient.m
//  stickr
//
//  Created by Kandula, Sandeep on 08/01/16.
//  Copyright © 2016 cariboutech. All rights reserved.
//

#import "StickrNetworkClient.h"

static NSString * const baseURLString = @"http://www.stickr.space/";
#define SECRET @"carlfarl"
#define SECRET_HEADER @"X-STICKR-INSIDER"

@implementation StickrNetworkClient

+ (instancetype)sharedClient {
    static StickrNetworkClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[StickrNetworkClient alloc] initWithBaseURL:[NSURL URLWithString:baseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [_sharedClient.requestSerializer setValue:SECRET forHTTPHeaderField:SECRET_HEADER];
    });
    
    return _sharedClient;
}

@end
