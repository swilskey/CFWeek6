//
//  ReservationService.h
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/10/15.
//  Copyright © 2015 Wilskey Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReservationService : NSObject
+ (NSArray *)availableRoomsForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
@end