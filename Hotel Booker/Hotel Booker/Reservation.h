//
//  Reservation.h
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/8/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guest, Room;

@interface Reservation : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Guest *guest;
@property (nonatomic, retain) Room *room;

@end
