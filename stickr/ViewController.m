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

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *stickrDataArray;

@end

@implementation ViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.stickrDataArray = [NSMutableArray new];
    
    stickrDataModel *dataM1 = [stickrDataModel new];
    dataM1.stickrID = @"1";
    dataM1.stickrTitle = @"Starbucks Daily Question";
    dataM1.stickrImageURL = @"";
    
    [self.stickrDataArray addObject:dataM1];
    
    stickrDataModel *dataM2 = [stickrDataModel new];
    dataM2.stickrID = @"2";
    dataM2.stickrTitle = @"Hilton Room Stickr";
    dataM2.stickrImageURL = @"";
    
    [self.stickrDataArray addObject:dataM2];
    
    stickrDataModel *dataM3 = [stickrDataModel new];
    dataM3.stickrID = @"3";
    dataM3.stickrTitle = @"AirBNB Recommendations";
    dataM3.stickrImageURL = @"";
    
    [self.stickrDataArray addObject:dataM3];
    
    stickrDataModel *dataM4 = [stickrDataModel new];
    dataM4.stickrID = @"4";
    dataM4.stickrTitle = @"NYC Taxicab Headlines";
    dataM4.stickrImageURL = @"";
    
    [self.stickrDataArray addObject:dataM4];
    
    stickrDataModel *dataM5 = [stickrDataModel new];
    dataM5.stickrID = @"5";
    dataM5.stickrTitle = @"Techcrunch Interview";
    dataM5.stickrImageURL = @"";
    
    [self.stickrDataArray addObject:dataM5];
    
    stickrDataModel *dataM6 = [stickrDataModel new];
    dataM6.stickrID = @"6";
    dataM6.stickrTitle = @"GigaOHM Blog";
    dataM6.stickrImageURL = @"";
    
    [self.stickrDataArray addObject:dataM6];
    
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
