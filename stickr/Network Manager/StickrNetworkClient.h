//
//  StickrNetworkClient.h
//  stickr
//
//  Created by Kandula, Sandeep on 08/01/16.
//  Copyright © 2016 cariboutech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface StickrNetworkClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
