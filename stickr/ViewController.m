//
//  ViewController.m
//  stickr
//
//  Created by Kandula, Sandeep on 04/01/16.
//  Copyright © 2016 cariboutech. All rights reserved.
//

#import "ViewController.h"
#import "StickrDetailsViewController.h"
#import "stickrDataModel.h"
#import "StickrNetworkAdapter.h"
#import "SVProgressHUD.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *stickrDataArray;
@property (strong, nonatomic) StickrNetworkAdapter *nwAdapter;

@end

@implementation ViewController

#pragma mark - LifeCycle Methods

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    _nwAdapter = [StickrNetworkAdapter new];
    [_nwAdapter getPath:@"api/v1/templates" success:^(id response){
        
        [SVProgressHUD dismiss];
        self.stickrDataArray = (NSMutableArray *)response;
        [self.tableView reloadData];
        
    }failure:^(NSError *error){
    
        [SVProgressHUD dismiss];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                    message:@"Unable to load Titles. Please try again later."
                                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* OK_button = [UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * action)
                                                 {
                                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                                     
                                                 }];
        
        [alert addAction:OK_button];
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - UITableView Delegate Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.stickrDataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *titleCell = @"titleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCell];
    
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    
    stickrDataModel *dataModel = [self.stickrDataArray objectAtIndex:indexPath.row];
    label.text = dataModel.stickrTitle;
    
    return cell;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *titleCell = @"titleCell";
    static UITableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [tableView dequeueReusableCellWithIdentifier:titleCell];
    });
    
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    
    stickrDataModel *dataModel = [self.stickrDataArray objectAtIndex:indexPath.row];
    label.text = dataModel.stickrTitle;
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
    
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StickrDetailsViewController *detailsVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([StickrDetailsViewController class])];
    
    detailsVC.dataModel = [self.stickrDataArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detailsVC animated:YES];
    
}

@end
