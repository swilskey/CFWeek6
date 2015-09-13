//
//  CreateReservationViewController.m
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/9/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

#import "CreateReservationViewController.h"
#import "SelectAvailableRoomsViewController.h"
#import "DateValidator.h"

@interface CreateReservationViewController ()

@property (strong,nonatomic) UIView *rootView;
@property (strong,nonatomic) UILabel *startDateLabel;
@property (strong,nonatomic) UILabel *endDateLabel;
@property (strong,nonatomic) UIDatePicker *datePicker;
@property (strong,nonatomic) UIToolbar *pickerToolbar;
@property (strong,nonatomic) UITextField *startDateField;
@property (strong,nonatomic) UITextField *endDateField;
@property (strong,nonatomic) UIBarButtonItem *barDoneButton;
@property (strong,nonatomic) UITextField *firstNameField;
@property (strong,nonatomic) UITextField *lastNameField;
@property (strong,nonatomic) UIButton *confirmDatesButton;

@property (strong,nonatomic) NSDate *startDate;
@property (strong,nonatomic) NSDate *endDate;

@end

@implementation CreateReservationViewController

- (void)loadView {
  self.rootView = [[UIView alloc] init];
  self.rootView.backgroundColor = [UIColor whiteColor];
  
  self.startDateLabel = [[UILabel alloc] init];
  [self.startDateLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  self.startDateLabel.text = @"Choose Start Date";
  [self.rootView addSubview:self.startDateLabel];
  
  self.endDateLabel = [[UILabel alloc] init];
  self.endDateLabel.text = @"Choose End Date";
  [self.endDateLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.rootView addSubview:self.endDateLabel];
  
  self.pickerToolbar = [[UIToolbar alloc] init];
  self.pickerToolbar.barStyle = UIBarStyleDefault;
  self.pickerToolbar.translucent = true;
  [self.pickerToolbar sizeToFit];
  
  self.barDoneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self.datePicker action:@selector(donePicker:)];
  NSArray *barItems = [[NSArray alloc] initWithObjects:self.barDoneButton, nil];
  [self.pickerToolbar setItems:barItems animated:true];
  
  self.datePicker = [[UIDatePicker alloc] init];
  [self.datePicker setUserInteractionEnabled:true];
  self.datePicker.datePickerMode = UIDatePickerModeDate;
  
  self.startDateField = [[UITextField alloc] init];
  self.startDateField.borderStyle = UITextBorderStyleRoundedRect;
  [self.startDateField setInputView:self.datePicker];
  [self.startDateField setInputAccessoryView:self.pickerToolbar];
  [self.startDateField setPlaceholder:@"Start Date"];
  [self.startDateField setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.rootView addSubview:self.startDateField];
  
  self.endDateField = [[UITextField alloc] init];
  self.endDateField.borderStyle = UITextBorderStyleRoundedRect;
  [self.endDateField setInputView:self.datePicker];
  [self.endDateField setInputAccessoryView:self.pickerToolbar];
  [self.endDateField setPlaceholder:@"End Date"];
  [self.endDateField setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.rootView addSubview:self.endDateField];
  
  self.firstNameField = [[UITextField alloc] init];
  self.firstNameField.borderStyle = UITextBorderStyleRoundedRect;
  [self.firstNameField setPlaceholder:@"First Name"];
  [self.firstNameField setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.rootView addSubview:self.firstNameField];
  
  self.lastNameField = [[UITextField alloc] init];
  self.lastNameField.borderStyle = UITextBorderStyleRoundedRect;
  [self.lastNameField setPlaceholder:@"Last Name"];
  [self.lastNameField setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.rootView addSubview:self.lastNameField];
  
  self.confirmDatesButton = [[UIButton alloc] init];
  [self.confirmDatesButton setTitle:@"Confirm Dates" forState:UIControlStateNormal];
  [self.confirmDatesButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.confirmDatesButton setBackgroundColor:[UIColor lightGrayColor]];
  [self.confirmDatesButton addTarget:self action:@selector(confirmDatesAction:) forControlEvents:UIControlEventTouchUpInside];
  [self.confirmDatesButton setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.rootView addSubview:self.confirmDatesButton];
  
  [self setUpConstraints];
  
  self.view = self.rootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSDictionary *views = @{@"topGuide":self.topLayoutGuide, @"firstNameField":self.firstNameField};
  
  NSArray *firstNameVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[topGuide]-8-[firstNameField]" options:0 metrics:nil views:views];
  [self.rootView addConstraints:firstNameVerticalConstraints];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)donePicker:(UIDatePicker *)sender {
  if ([self.startDateField isFirstResponder]) {
    
    [self.startDateField resignFirstResponder];
    self.startDate = self.datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"cccc, MMM d"];
    NSString *prettyVersion = [dateFormat stringFromDate:self.startDate];
    self.startDateField.text = prettyVersion;
  } else if ([self.endDateField isFirstResponder]) {
    
    [self.endDateField resignFirstResponder];
    self.endDate = self.datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"cccc, MMM d"];
    NSString *prettyVersion = [dateFormat stringFromDate:self.endDate];
    self.endDateField.text = prettyVersion;
  }
}

- (void)confirmDatesAction:(UIButton *)sender {
  if ([DateValidator validRangeStartDate:self.startDate endDate:self.endDate]) {
    SelectAvailableRoomsViewController *destination = [[SelectAvailableRoomsViewController alloc] init];
    destination.startDate = self.startDate;
    destination.endDate = self.endDate;
    destination.firstName = self.firstNameField.text;
    destination.lastName = self.lastNameField.text;
    [self.navigationController pushViewController:destination animated:true];
    
  } else {
    NSLog(@"Not Valid Dates");
  }
}

#pragma mark - Constraint Setups

- (void)setUpConstraints {
  NSDictionary *views = @{@"firstNameField":self.firstNameField, @"lastNameField":self.lastNameField, @"startDateLabel":self.startDateLabel, @"startDateField":self.startDateField, @"endDateLabel":self.endDateLabel, @"endDateField":self.endDateField, @"confirmDatesButton":self.confirmDatesButton};
  
  NSArray *firstNameHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[firstNameField]-8-|" options:0 metrics:nil views:views];
  
  NSArray *lastNameVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[firstNameField]-8-[lastNameField]" options:0 metrics:nil views:views];
  NSArray *lastNameHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[lastNameField]-8-|" options:0 metrics:nil views:views];
  
  NSArray *startDateLableVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastNameField]-8-[startDateLabel]" options:0 metrics:nil views:views];
  NSArray *startDateLabelHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[startDateLabel]-8-|" options:0 metrics:nil views:views];
  
  NSArray *startDateFieldVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[startDateLabel]-8-[startDateField]" options:0 metrics:nil views:views];
  NSArray *startDateFieldHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[startDateField]-8-|" options:0 metrics:nil views:views];
  
  NSArray *endDateLabelVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[startDateField]-8-[endDateLabel]" options:0 metrics:nil views:views];
  NSArray *endDateLabelHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[endDateLabel]-8-|" options:0 metrics:nil views:views];
  
  NSArray *endDateFieldVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[endDateLabel]-8-[endDateField]" options:0 metrics:nil views:views];
  NSArray *endDateFieldHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[endDateField]-8-|" options:0 metrics:nil views:views];
  
  NSArray *confirmDatesButtonVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[confirmDatesButton]-8-|" options:0 metrics:nil views:views];
  NSArray *confirmDatesButtonHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[confirmDatesButton]-8-|" options:0 metrics:nil views:views];
  
  [self.rootView addConstraints:firstNameHorizontalConstraint];
  [self.rootView addConstraints:lastNameVerticalConstraint];
  [self.rootView addConstraints:lastNameHorizontalConstraint];
  [self.rootView addConstraints:startDateLableVerticalConstraints];
  [self.rootView addConstraints:startDateLabelHorizontalConstraint];
  [self.rootView addConstraints:startDateFieldVerticalConstraint];
  [self.rootView addConstraints:startDateFieldHorizontalConstraint];
  [self.rootView addConstraints:endDateLabelVerticalConstraint];
  [self.rootView addConstraints:endDateLabelHorizontalConstraint];
  [self.rootView addConstraints:endDateFieldVerticalConstraint];
  [self.rootView addConstraints:endDateFieldHorizontalConstraint];
  [self.rootView addConstraints:confirmDatesButtonVerticalConstraint];
  [self.rootView addConstraints:confirmDatesButtonHorizontalConstraint];
  
}
@end
