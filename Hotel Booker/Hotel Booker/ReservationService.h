//
//  ReservationService.h
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/10/15.
//  Copyright © 2015 Wilskey Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guest,Reservation,Room;

@interface ReservationService : NSObject
+ (NSArray *)availableRoomsForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
+ (NSFetchedResultsController *)fetchControllerAvailableRoomsForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
+ (void) createReservationforGuest:(Guest *)guest inRoom:(Room *)room fromDate:(NSDate *)startDate toDate:(NSDate *)endDate;
+ (NSArray *)getAllReservations;
@end