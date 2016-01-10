//
//  StickrDetailsViewController.m
//  stickr
//
//  Created by Kandula, Sandeep on 05/01/16.
//  Copyright © 2016 cariboutech. All rights reserved.
//

#import "StickrDetailsViewController.h"
#import "SVProgressHUD.h"
#import "StickrNetworkAdapter.h"

@interface StickrDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *stickrImage;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (strong, nonatomic) StickrNetworkAdapter *nwAdapter;

- (IBAction)backButtonClicked:(id)sender;
- (IBAction)applyButtonClicked:(id)sender;

@end

@implementation StickrDetailsViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Apply Broder to Apply Button
    self.applyButton.layer.borderColor = [UIColor colorWithRed:60.0/255.0 green:222.0/255.0 blue:148.0/255.0 alpha:1.0].CGColor;
    self.applyButton.layer.borderWidth = 1.0;
    self.applyButton.layer.cornerRadius = 25.0;
    self.applyButton.layer.masksToBounds = YES;
    [self.applyButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:60.0/255.0 green:222.0/255.0 blue:148.0/255.0 alpha:1.0]] forState:UIControlStateHighlighted];
    
    //assign selected stickr title
    self.headerLabel.text = self.dataModel.stickrTitle;
    
    //Load Image
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    _nwAdapter = [StickrNetworkAdapter new];
    [_nwAdapter loadImageWithURL:[NSString stringWithFormat:@"api/v1/templates/%@.png",self.dataModel.stickrID]
                andImageID:self.dataModel.stickrID
                andImageView:(UIImageView *)self.stickrImage
                success:^(id response){
    
      [SVProgressHUD dismiss];
      
      //self.stickrImage.image = (UIImage *)response;
                      
      //Apply Border to Stickr Image
      self.stickrImage.layer.borderColor = [UIColor lightGrayColor].CGColor;//[UIColor colorWithRed:211.0 green:211.0 blue:211.0 alpha:0].CGColor;
      self.stickrImage.layer.borderWidth = 1.0;
                  
    }failure:^(NSError *error){
        
        [SVProgressHUD dismiss];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                        message:@"Unable to load Template Image. Please try again later."
                                                                 preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* OK_button = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                    {
                                        [alert dismissViewControllerAnimated:YES
                                                                  completion:nil];
                                        
                                    }];
        
        [alert addAction:OK_button];
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
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
