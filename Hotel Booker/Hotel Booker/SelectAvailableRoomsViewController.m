//
//  SelectAvailableRoomsViewController.m
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/10/15.
//  Copyright © 2015 Wilskey Labs. All rights reserved.
//

#import "SelectAvailableRoomsViewController.h"
#import "ConfirmReservationViewController.h"
#import "ReservationService.h"
#import "Room.h"

@interface SelectAvailableRoomsViewController() <UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UIView *rootView;
@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSArray *roomsAvailable;
@property (strong,nonatomic) NSFetchedResultsController *fetchController;

@end

@implementation SelectAvailableRoomsViewController

- (void)loadView {
  self.rootView = [[UIView alloc] init];
  self.rootView.backgroundColor = [UIColor whiteColor];
  
  self.tableView = [[UITableView alloc] init];
  [self.tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.rootView addSubview:self.tableView];
  
  NSDictionary *views = @{@"tableView":self.tableView};
  
  NSArray *roomTableViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|" options:0 metrics:nil views:views];
  [self.rootView addConstraints:roomTableViewVerticalConstraints];
  
  NSArray *roomTableViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-8)-[tableView]-8-|" options:0 metrics:nil views:views];
  [self.rootView addConstraints:roomTableViewHorizontalConstraints];
  
  self.view = self.rootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"AvailableRoomCell"];
  
  self.roomsAvailable = [ReservationService availableRoomsForStartDate:self.startDate endDate:self.endDate];
  //self.fetchController = [ReservationService fetchControllerAvailableRoomsForStartDate:self.startDate endDate:self.endDate];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//  NSLog(@"Section Count: %lu", self.fetchController.sections.count);
//  return self.fetchController.sections.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.roomsAvailable.count;
  
//  if (self.fetchController.sections.count > 0) {
//    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchController.sections objectAtIndex:section];
//    NSLog(@"Rows Count: %lu", (unsigned long)[sectionInfo numberOfObjects]);
//    return [sectionInfo numberOfObjects];
//  } else {
//    return 0;
//  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AvailableRoomCell" forIndexPath:indexPath];
  
  Room *room = [self.roomsAvailable objectAtIndex:indexPath.row];
  //Room *room = [self.fetchController objectAtIndexPath:indexPath];
  
  cell.textLabel.text = room.number.stringValue;
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  ConfirmReservationViewController *destination = [[ConfirmReservationViewController alloc] init];
  destination.firstName = self.firstName;
  destination.lastName = self.lastName;
  destination.startDate = self.startDate;
  destination.endDate = self.endDate;
  destination.room = [self.roomsAvailable objectAtIndex:indexPath.row];
  
  [self.navigationController pushViewController:destination animated:true];
}

@end