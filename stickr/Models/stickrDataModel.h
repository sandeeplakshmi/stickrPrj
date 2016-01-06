//
//  stickrDataModel.h
//  stickr
//
//  Created by Kandula, Sandeep on 05/01/16.
//  Copyright © 2016 cariboutech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface stickrDataModel : NSObject

@property (strong, nonatomic) id stickrID;
@property (strong, nonatomic) NSString *stickrTitle;
@property (strong, nonatomic) NSString *stickrImageURL;

@end
