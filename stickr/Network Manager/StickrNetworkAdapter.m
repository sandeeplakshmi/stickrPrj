//
//  StickrNetworkAdapter.m
//  stickr
//
//  Created by Kandula, Sandeep on 08/01/16.
//  Copyright © 2016 cariboutech. All rights reserved.
//

#import "StickrNetworkAdapter.h"
#import "StickrNetworkClient.h"
#import "stickrDataModel.h"
#import "AFImageDownloader.h"

@implementation StickrNetworkAdapter

- (void)getPath:(NSString *)path
        success:(ResponseBlock)success
        failure:(FailureBlock)failure
{

    [StickrNetworkClient sharedClient].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                                                    @"text/javascript",
                                                                                    @"application/json",
                                                                                    @"text/json",nil];
    
    NSLog(@"%@",[[StickrNetworkClient sharedClient].responseSerializer acceptableContentTypes]);
    [[StickrNetworkClient sharedClient] GET:path parameters:nil progress:nil
                                    success:^(NSURLSessionDataTask * __unused task, id JSON) {
    
        NSMutableArray *dataArray = [NSMutableArray new];
        for(id templateDict in JSON){
         
            stickrDataModel *dataModel = [stickrDataModel new];
            dataModel.stickrID = [templateDict objectForKey:@"id"];
            dataModel.stickrTitle = [templateDict objectForKey:@"name"];
            
            [dataArray addObject:dataModel];
            
        }
        
        success(dataArray);
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        
        failure(error);
        
    }];
    
}

- (void)loadImage:(UIImageView *)imageView
          withURL:(NSString *)path
          success:(ResponseBlock)success
          failure:(FailureBlock)failure
{
    
    [StickrNetworkClient sharedClient].responseSerializer = [AFImageResponseSerializer serializer];
    [[StickrNetworkClient sharedClient] GET:path parameters:nil progress:nil
                                    success:^(NSURLSessionDataTask * __unused task, id JSON) {
                                        
                                        imageView.image = (UIImage *)JSON;
                                        success(JSON);
                                        
                                    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
                                        
                                        failure(error);
                                        
                                    }];

    
}

- (void)postPath:(NSString *)path
        bodyParameter:(NSDictionary *)parameters
        success:(ResponseBlock)success
        failure:(FailureBlock)failure
{
    
    
}


@end
