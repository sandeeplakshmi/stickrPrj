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

- (void)loadImageWithURL:(NSString *)path
        andImageID:(NSString*)templateID
        andImageView:(UIImageView *)imageView
        success:(ResponseBlock)success
        failure:(FailureBlock)failure
{
    
    UIImage *savedImage = [self checkAndReturnIfImageSavedWithID:templateID];
    if(savedImage){
        imageView.image = savedImage;
        success(savedImage);
    }
    
    [StickrNetworkClient sharedClient].responseSerializer = [AFImageResponseSerializer serializer];
    [[StickrNetworkClient sharedClient] GET:path parameters:nil progress:nil
                                    success:^(NSURLSessionDataTask * __unused task, id JSON) {
                                        
                                        imageView.image = (UIImage*)JSON;
                                        success((UIImage*)JSON);
                                        [self SaveImage:(UIImage*)JSON withImageid:templateID];
                                        
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


- (UIImage *) checkAndReturnIfImageSavedWithID:(NSString *)imageId{
    
    NSString *filePath = [self documentsPathForFileName:[NSString stringWithFormat:@"%@.png",imageId]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:filePath])
       return [UIImage imageWithContentsOfFile:filePath];
    else
        return nil;
        
    
}

- (void) SaveImage:(UIImage *)image withImageid:(NSString *)imageId{
    
    NSString *filePath = [self documentsPathForFileName:[NSString stringWithFormat:@"%@.png",imageId]];
    NSData *pngData = UIImagePNGRepresentation(image);
    if([pngData writeToFile:filePath atomically:YES]){
        
        NSLog(@"Image saved successfully");
        
    }

}


- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}


@end
