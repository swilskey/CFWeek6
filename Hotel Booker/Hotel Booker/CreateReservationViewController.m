//
//  CreateReservationViewController.m
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/9/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

#import "CreateReservationViewController.h"

@interface CreateReservationViewController ()

@property (strong,nonatomic) UIView *rootView;
@property (strong,nonatomic) UILabel *startDateLabel;
@property (strong,nonatomic) UILabel *endDateLabel;
@property (strong,nonatomic) UIDatePicker *datePicker;
@property (strong,nonatomic) UIToolbar *pickerToolbar;
@property (strong,nonatomic) UITextField *startDateField;
@property (strong,nonatomic) UITextField *endDateField;
@property (strong,nonatomic) UIBarButtonItem *barDoneButton;

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
  
  self.barDoneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(donePicker)];
  NSArray *barItems = [[NSArray alloc] initWithObjects:self.barDoneButton, nil];
  
  self.datePicker = [[UIDatePicker alloc] init];
  [self.datePicker setUserInteractionEnabled:true];
  [self.pickerToolbar setItems:barItems animated:true];
  
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
  
  [self setUpConstraints];
  
  self.view = self.rootView;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSDictionary *views = @{@"topGuide":self.topLayoutGuide, @"startDateLabel":self.startDateLabel};
  
  NSArray *startLableVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[topGuide]-8-[startDateLabel]" options:0 metrics:nil views:views];
  [self.rootView addConstraints:startLableVerticalConstraints];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (void)donePicker {
  
}

- (void)setUpConstraints {
  NSDictionary *views = @{@"startDateLabel":self.startDateLabel, @"startDateField":self.startDateField, @"endDateLabel":self.endDateLabel, @"endDateField":self.endDateField};
  
  NSArray *startDateLabelHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[startDateLabel]-8-|" options:0 metrics:nil views:views];
  
  NSArray *startDateFieldVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[startDateLabel]-8-[startDateField]" options:0 metrics:nil views:views];
  NSArray *startDateFieldHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[startDateField]-8-|" options:0 metrics:nil views:views];
  
  NSArray *endDateLabelVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[startDateField]-8-[endDateLabel]" options:0 metrics:nil views:views];
  NSArray *endDateLabelHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[endDateLabel]-8-|" options:0 metrics:nil views:views];
  
  NSArray *endDateFieldVerticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[endDateLabel]-8-[endDateField]" options:0 metrics:nil views:views];
  NSArray *endDateFieldHorizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[endDateField]-8-|" options:0 metrics:nil views:views];
  
  [self.rootView addConstraints:startDateLabelHorizontalConstraint];
  [self.rootView addConstraints:startDateFieldVerticalConstraint];
  [self.rootView addConstraints:startDateFieldHorizontalConstraint];
  [self.rootView addConstraints:endDateLabelVerticalConstraint];
  [self.rootView addConstraints:endDateLabelHorizontalConstraint];
  [self.rootView addConstraints:endDateFieldVerticalConstraint];
  [self.rootView addConstraints:endDateFieldHorizontalConstraint];
  
}
@end
