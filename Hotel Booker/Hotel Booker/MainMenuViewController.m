//
//  MainMenuViewController.m
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/8/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ViewController.h"

@interface MainMenuViewController ()

@property (strong,nonatomic) UIView *rootView;
@property (strong,nonatomic) UIButton *browseHotelsButton;
@property (strong,nonatomic) UIButton *bookARoomButton;
@property (strong,nonatomic) UIButton *lookUpReservationsButton;
@end

@implementation MainMenuViewController

- (void)loadView {
  
  self.rootView = [[UIView alloc] init];
  self.rootView.backgroundColor = [UIColor whiteColor];
  
  self.browseHotelsButton = [[UIButton alloc] init];
  [self.browseHotelsButton setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.browseHotelsButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [self.browseHotelsButton setTitle:@"Browse Hotels" forState:UIControlStateNormal];
  [self.browseHotelsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.browseHotelsButton setBackgroundColor:[UIColor lightGrayColor]];
  [self.rootView addSubview:self.browseHotelsButton];
  
  self.bookARoomButton = [[UIButton alloc] init];
  [self.bookARoomButton setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.bookARoomButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [self.bookARoomButton setTitle:@"Book A Room" forState:UIControlStateNormal];
  [self.bookARoomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.bookARoomButton setBackgroundColor:[UIColor lightGrayColor]];
  [self.rootView addSubview:self.bookARoomButton];
  
  self.lookUpReservationsButton = [[UIButton alloc] init];
  [self.lookUpReservationsButton setTranslatesAutoresizingMaskIntoConstraints:false];
  [self.lookUpReservationsButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
  [self.lookUpReservationsButton setTitle:@"Look Up Reservation" forState:UIControlStateNormal];
  [self.lookUpReservationsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.lookUpReservationsButton setBackgroundColor:[UIColor lightGrayColor]];
  [self.rootView addSubview:self.lookUpReservationsButton];
  
  [self setAutoLayout];
  
  self.view = self.rootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)buttonPressed:(UIButton *)sender {
  if (sender == self.browseHotelsButton) {
    ViewController *destination = [[ViewController alloc] init];
    [self.navigationController pushViewController:destination animated:true];
  } else if (sender == self.bookARoomButton) {
    
  } else if (sender == self.lookUpReservationsButton) {
    
  }
}

-(void)setAutoLayout {
  NSDictionary *views = @{@"browseHotelsButton":self.browseHotelsButton,@"bookARoomButton":self.bookARoomButton,@"lookUpReservationButton":self.lookUpReservationsButton};
  
  NSArray *browseHotelsButtonVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[browseHotelsButton]" options:0 metrics:nil views:views];
  NSArray *browseHotelsButtonHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[browseHotelsButton]-8-|" options:0 metrics:nil views:views];
  
  NSArray *bookARoomButtonVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[browseHotelsButton]-8-[bookARoomButton]" options:0 metrics:nil views:views];
  NSArray *bookARoomButtonHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[bookARoomButton]-8-|" options:0 metrics:nil views:views];
  
  NSArray *lookUpReservationButtonVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[bookARoomButton]-8-[lookUpReservationButton]" options:0 metrics:nil views:views];
  NSArray *lookUpReservationButtonHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[lookUpReservationButton]-8-|" options:0 metrics:nil views:views];
  
  [self.rootView addConstraints:browseHotelsButtonHorizontalLayout];
  [self.rootView addConstraints:browseHotelsButtonVerticalLayout];
  [self.rootView addConstraints:bookARoomButtonHorizontalLayout];
  [self.rootView addConstraints:bookARoomButtonVerticalLayout];
  [self.rootView addConstraints:lookUpReservationButtonHorizontalLayout];
  [self.rootView addConstraints:lookUpReservationButtonVerticalLayout];
  
}

@end
