//
//  StickrNetworkAdapter.h
//  stickr
//
//  Created by Kandula, Sandeep on 08/01/16.
//  Copyright © 2016 cariboutech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ResponseBlock)(id);
typedef void(^FailureBlock)(NSError*);

@interface StickrNetworkAdapter : NSObject

- (void)getPath:(NSString *)path
        success:(ResponseBlock)success
        failure:(FailureBlock)failure;

- (void)loadImageWithURL:(NSString *)path
        andImageID:(NSString*)templateID
        andImageView:(UIImageView *)imageView
        success:(ResponseBlock)success
        failure:(FailureBlock)failure;


- (void)postPath:(NSString *)path
        bodyParameter:(NSDictionary *)parameters
        success:(ResponseBlock)success
        failure:(FailureBlock)failure;

@end
