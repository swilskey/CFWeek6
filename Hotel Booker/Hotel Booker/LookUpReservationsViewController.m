//
//  LookUpReservationsViewController.m
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/12/15.
//  Copyright © 2015 Wilskey Labs. All rights reserved.
//

#import "LookUpReservationsViewController.h"
#import "ReservationService.h"
#import "Reservation.h"
#import "Guest.h"

@interface LookUpReservationsViewController() <UITableViewDataSource>

@property (strong,nonatomic) UIView *rootView;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *reservations;

@end

@implementation LookUpReservationsViewController

- (void)loadView {
  self.rootView = [[UIView alloc] init];
  self.rootView.backgroundColor = [UIColor whiteColor];
  
  self.tableView = [[UITableView alloc] init];
  [self.tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ReservationCell"];
  [self.rootView addSubview:self.tableView];
  
  [self setUpConstraints];
  
  self.view = self.rootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableView.dataSource = self;
  
  self.reservations = [ReservationService getAllReservations];
  [self.tableView reloadData];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)setUpConstraints {
  NSDictionary *views = @{@"tableView":self.tableView};
  
  NSArray *tableViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[tableView]-8-|" options:0 metrics:nil views:views];
  NSArray *tableViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|" options:0 metrics:nil views:views];
  
  [self.rootView addConstraints:tableViewVerticalConstraints];
  [self.rootView addConstraints:tableViewHorizontalConstraints];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.reservations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationCell" forIndexPath:indexPath];
  
  Reservation *reservation = [self.reservations objectAtIndex:indexPath.row];
  Guest *guest = reservation.guest;
  cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", guest.firstName, guest.lastName];
  
  return cell;
}

@end
