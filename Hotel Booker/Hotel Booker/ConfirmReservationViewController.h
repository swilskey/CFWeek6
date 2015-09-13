//
//  ConfirmReservationViewController.h
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/11/15.
//  Copyright © 2015 Wilskey Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Room;

@interface ConfirmReservationViewController : UIViewController
@property (strong,nonatomic) NSString *firstName;
@property (strong,nonatomic) NSString *lastName;
@property (strong,nonatomic) NSDate *startDate;
@property (strong,nonatomic) NSDate *endDate;
@property (strong,nonatomic) Room *room;
@end
