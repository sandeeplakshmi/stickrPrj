//
//  StickrDetailsViewController.m
//  stickr
//
//  Created by Kandula, Sandeep on 05/01/16.
//  Copyright © 2016 cariboutech. All rights reserved.
//

#import "StickrDetailsViewController.h"

@interface StickrDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *stickrImage;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;

- (IBAction)backButtonClicked:(id)sender;
- (IBAction)applyButtonClicked:(id)sender;

@end

@implementation StickrDetailsViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Apply Border to Stickr Image
    self.stickrImage.layer.borderColor = [UIColor lightGrayColor].CGColor;//[UIColor colorWithRed:211.0 green:211.0 blue:211.0 alpha:0].CGColor;
    self.stickrImage.layer.borderWidth = 1.0;
    
    
    //Apply Broder to Apply Button
    self.applyButton.layer.borderColor = [UIColor colorWithRed:60.0/255.0 green:222.0/255.0 blue:148.0/255.0 alpha:1.0].CGColor;
    self.applyButton.layer.borderWidth = 1.0;
    self.applyButton.layer.cornerRadius = 25.0;
    self.applyButton.layer.masksToBounds = YES;
    [self.applyButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:60.0/255.0 green:222.0/255.0 blue:148.0/255.0 alpha:1.0]] forState:UIControlStateHighlighted];
    
    //assign selected stickr title
    self.headerLabel.text = self.dataModel.stickrTitle;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Methods

- (IBAction)backButtonClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)applyButtonClicked:(id)sender {
    
    //TODO : apply button clicked logic
    
}

#pragma mark - Utility Methods

- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
