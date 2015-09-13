//
//  SelectAvailableRoomsViewController.h
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/10/15.
//  Copyright © 2015 Wilskey Labs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SelectAvailableRoomsViewController : UIViewController

@property (strong,nonatomic) NSDate *startDate;
@property (strong,nonatomic) NSDate *endDate;
@property (strong,nonatomic) NSString *firstName;
@property (strong,nonatomic) NSString *lastName;

@end