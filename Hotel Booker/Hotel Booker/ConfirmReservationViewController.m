//
//  ConfirmReservationViewController.m
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/11/15.
//  Copyright © 2015 Wilskey Labs. All rights reserved.
//

#import "ConfirmReservationViewController.h"
#import "ReservationService.h"
#import "AppDelegate.h"
#import "CoreDataStack.h"
#import "Room.h"
#import "Hotel.h"
#import "Guest.h"

#import <CoreData/CoreData.h>

@interface ConfirmReservationViewController ()

@property (strong,nonatomic) UIView *rootView;
@property (strong,nonatomic) UILabel *firstNameLabel;
@property (strong,nonatomic) UILabel *lastNameLabel;
@property (strong,nonatomic) UILabel *startDateLabel;
@property (strong,nonatomic) UILabel *endDateLabel;
@property (strong,nonatomic) UILabel *hotelLabel;
@property (strong,nonatomic) UILabel *roomNumber;
@property (strong,nonatomic) UIButton *confirmReservationButton;
@property (strong,nonatomic) UIButton *cancelReservationButton;

@end

@implementation ConfirmReservationViewController

- (void)loadView {
  self.rootView = [[UIView alloc] init];
  self.rootView.backgroundColor = [UIColor whiteColor];
  
  self.firstNameLabel = [[UILabel alloc] init];
  [self.firstNameLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.rootView addSubview:self.firstNameLabel];
  
  self.lastNameLabel = [[UILabel alloc] init];
  [self.lastNameLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.rootView addSubview:self.lastNameLabel];
  
  self.startDateLabel = [[UILabel alloc] init];
  [self.startDateLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.rootView addSubview:self.startDateLabel];
  
  self.endDateLabel = [[UILabel alloc] init];
  [self.endDateLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.rootView addSubview:self.endDateLabel];
  
  self.hotelLabel = [[UILabel alloc] init];
  [self.hotelLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.rootView addSubview:self.hotelLabel];
  
  self.roomNumber = [[UILabel alloc] init];
  [self.roomNumber setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.rootView addSubview:self.roomNumber];
  
  self.confirmReservationButton = [[UIButton alloc] init];
  [self.confirmReservationButton setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.confirmReservationButton setTitle:@"Confirm Reservation" forState:UIControlStateNormal];
  [self.confirmReservationButton setBackgroundColor:[UIColor blueColor]];
  [self.confirmReservationButton addTarget:self action:@selector(confirmReservationAction:) forControlEvents:UIControlEventTouchUpInside];
  [self.rootView addSubview:self.confirmReservationButton];
  
  self.cancelReservationButton = [[UIButton alloc] init];
  [self.cancelReservationButton setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.cancelReservationButton setTitle:@"Cancel Reservation" forState:UIControlStateNormal];
  [self.cancelReservationButton setBackgroundColor:[UIColor redColor]];
  [self.cancelReservationButton addTarget:self action:@selector(cancelReservationAction:) forControlEvents:UIControlEventTouchUpInside];
  [self.rootView addSubview:self.cancelReservationButton];
  
  [self setUpConstraints];
  
  self.view = self.rootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSDictionary *views = @{@"topGuide":self.topLayoutGuide, @"firstNameLabel":self.firstNameLabel};
  
  NSArray *firstNameVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[topGuide]-8-[firstNameLabel]" options:0 metrics:nil views:views];
  [self.rootView addConstraints:firstNameVerticalConstraints];
  
  self.firstNameLabel.text = self.firstName;
  self.lastNameLabel.text = self.lastName;
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"cccc, MMM d"];
  NSString *startDateString = [dateFormat stringFromDate:self.startDate];
  self.startDateLabel.text = startDateString;

  NSString *endDateString = [dateFormat stringFromDate:self.endDate];
  self.endDateLabel.text = endDateString;
  
  self.hotelLabel.text = self.room.hotel.name;
  self.roomNumber.text = self.room.number.stringValue;
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

- (void)confirmReservationAction:(UIButton *)sender {
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:appDelegate.coreDataStack.managedObjectContext];
  guest.firstName = self.firstName;
  guest.lastName = self.lastName;
  
  [ReservationService createReservationforGuest:guest inRoom:self.room fromDate:self.startDate toDate:self.endDate];
  
  [self.navigationController popToRootViewControllerAnimated:true];
}

- (void)cancelReservationAction:(UIButton *)sender {
  [self.navigationController popToRootViewControllerAnimated:true];
}

#pragma mark - SetupConstraints
- (void)setUpConstraints {
  
  NSDictionary *views = @{@"firstNameLabel":self.firstNameLabel, @"lastNameLabel":self.lastNameLabel, @"startDateLabel":self.startDateLabel, @"endDateLabel":self.endDateLabel, @"confirmReservationButton":self.confirmReservationButton, @"cancelReservationButton":self.cancelReservationButton, @"hotelLabel":self.hotelLabel, @"roomNumber":self.roomNumber};
  
  NSArray *firstNameLabelHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[firstNameLabel]-8-|" options:0 metrics:nil views:views];
  NSArray *lastNameLabelVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[firstNameLabel]-8-[lastNameLabel]" options:0 metrics:nil views:views];
  NSArray *lastNameLabelHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[lastNameLabel]-8-|" options:0 metrics:nil views:views];
  NSArray *startDateLabelVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastNameLabel]-8-[startDateLabel]" options:0 metrics:nil views:views];
  NSArray *startDateLabelHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[startDateLabel]-8-|" options:0 metrics:nil views:views];
  NSArray *endDateLabelVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[startDateLabel]-8-[endDateLabel]" options:0 metrics:nil views:views];
  NSArray *endDateLabelHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[endDateLabel]-8-|" options:0 metrics:nil views:views];
  
  NSArray *hotelVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[endDateLabel]-8-[hotelLabel]" options:0 metrics:nil views:views];
  NSArray *hotelHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[hotelLabel]-8-|" options:0 metrics:nil views:views];
  NSArray *roomVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[hotelLabel]-8-[roomNumber]" options:0 metrics:nil views:views];
  NSArray *roomHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[roomNumber]-8-|" options:0 metrics:nil views:views];
  
  NSArray *confirmReservationVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[confirmReservationButton]-8-[cancelReservationButton]" options:0 metrics:nil views:views];
  NSArray *confirmReservationHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[confirmReservationButton]-8-|" options:0 metrics:nil views:views];
  NSArray *cancelReservationVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[cancelReservationButton]-8-|" options:0 metrics:nil views:views];
  NSArray *cancelReservationHorizontalConstrain = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[cancelReservationButton]-8-|" options:0 metrics:nil views:views];
  
  [self.rootView addConstraints:firstNameLabelHorizontalConstraint];
  [self.rootView addConstraints:lastNameLabelVerticalConstraint];
  [self.rootView addConstraints:lastNameLabelHorizontalConstraint];
  [self.rootView addConstraints:startDateLabelVerticalConstraint];
  [self.rootView addConstraints:startDateLabelHorizontalConstraint];
  [self.rootView addConstraints:endDateLabelVerticalConstraint];
  [self.rootView addConstraints:endDateLabelHorizontalConstraint];
  [self.rootView addConstraints:hotelVerticalConstraint];
  [self.rootView addConstraints:hotelHorizontalConstraint];
  [self.rootView addConstraints:roomVerticalConstraint];
  [self.rootView addConstraints:roomHorizontalConstraint];
  [self.rootView addConstraints:cancelReservationVerticalConstraint];
  [self.rootView addConstraints:cancelReservationHorizontalConstrain];
  [self.rootView addConstraints:confirmReservationVerticalConstraint];
  [self.rootView addConstraints:confirmReservationHorizontalConstraint];
  
}

@end
