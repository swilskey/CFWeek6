//
//  DateValidator.m
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/10/15.
//  Copyright © 2015 Wilskey Labs. All rights reserved.
//

#import "DateValidator.h"

@implementation DateValidator

+ (BOOL)validRangeStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  return [startDate compare:endDate] == NSOrderedAscending ? true : false;
}

@end