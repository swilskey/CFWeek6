//
//  SelectAvailableRoomsViewController.m
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/10/15.
//  Copyright © 2015 Wilskey Labs. All rights reserved.
//

#import "SelectAvailableRoomsViewController.h"
#import "ReservationService.h"

@interface SelectAvailableRoomsViewController ()

@property (strong,nonatomic) UIView *rootView;
@property (strong,nonatomic) UITableView *tableView;

@end

@implementation SelectAvailableRoomsViewController

- (void)loadView {
  self.rootView = [[UIView alloc] init];
  self.rootView.backgroundColor = [UIColor whiteColor];
  
  self.tableView = [[UITableView alloc] init];
  [self.rootView addSubview:self.tableView];
  
  self.view = self.rootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [ReservationService availableRoomsForStartDate:self.startDate endDate:self.endDate];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end