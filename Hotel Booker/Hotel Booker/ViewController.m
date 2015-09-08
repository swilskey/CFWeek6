//
//  ViewController.m
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/7/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

#import "ViewController.h"
#import "RoomViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"

#import <CoreData/CoreData.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *hotels;
@property (strong,nonatomic) AppDelegate *appDelegate;

@property (strong,nonatomic) UITableView *hotelTableView;
@end

@implementation ViewController

- (void)loadView {
//  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor whiteColor];
  
  self.hotelTableView = [[UITableView alloc] init];
  [self.hotelTableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:self.hotelTableView];
  
  NSDictionary *views = @{@"hotelTableView":self.hotelTableView};
  
  NSArray *hotelTableViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[hotelTableView]-0-|" options:0 metrics:nil views:views];
  [rootView addConstraints:hotelTableViewVerticalConstraints];
  
  NSArray *hotelTableViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-8)-[hotelTableView]-8-|" options:0 metrics:nil views:views];
  [rootView addConstraints:hotelTableViewHorizontalConstraints];
  
  self.view = rootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.appDelegate = [UIApplication sharedApplication].delegate;
  self.hotelTableView.dataSource = self;
  self.hotelTableView.delegate = self;
  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  
  NSError *fetchError;
  self.hotels = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  NSLog(@"Hotels Count: %lu", (unsigned long)self.hotels.count);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma Mark - Navigation

- (void) pushRoomViewController:(NSInteger)index {
  RoomViewController *destination = [[RoomViewController alloc] init];
  destination.hotel = [self.hotels objectAtIndex:index];
  
  [self.navigationController pushViewController:destination animated:true];
}

#pragma Mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.hotels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelCell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HotelCell"];
  }
  Hotel *hotel = [self.hotels objectAtIndex:indexPath.row];
  cell.textLabel.text = hotel.name;
  return cell;
}

#pragma Mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self pushRoomViewController:indexPath.row];
}

@end