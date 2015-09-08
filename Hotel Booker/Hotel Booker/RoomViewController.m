//
//  RoomViewController.m
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/8/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

#import "RoomViewController.h"
#import "Room.h"
#import "AppDelegate.h"

@interface RoomViewController() <UITableViewDataSource>
@property (strong,nonatomic) UITableView *roomTableView;
@property (strong,nonatomic) AppDelegate *appDelegate;
@property (strong,nonatomic) NSArray *rooms;
@end

@implementation RoomViewController

- (void)loadView {
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor whiteColor];
  
  self.roomTableView = [[UITableView alloc] init];
  [self.roomTableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:self.roomTableView];
  
  NSDictionary *views = @{@"roomTableView":self.roomTableView};
  
  NSArray *roomTableViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[roomTableView]-0-|" options:0 metrics:nil views:views];
  [rootView addConstraints:roomTableViewVerticalConstraints];
  
  NSArray *roomTableViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-8)-[roomTableView]-8-|" options:0 metrics:nil views:views];
  [rootView addConstraints:roomTableViewHorizontalConstraints];
  
  self.view = rootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.roomTableView.dataSource = self;
  self.appDelegate = [UIApplication sharedApplication].delegate;
  
  self.rooms = [[NSArray alloc] initWithArray:[self.hotel.rooms allObjects]];
  

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma Mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.rooms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomCell"];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomCell"];
  }
  
  Room *room = [self.rooms objectAtIndex:indexPath.row];
  cell.textLabel.text = [NSString stringWithFormat:@"%@",room.number];
  
  return cell;
}

@end
