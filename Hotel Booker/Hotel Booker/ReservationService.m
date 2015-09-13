//
//  ReservationService.m
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/10/15.
//  Copyright © 2015 Wilskey Labs. All rights reserved.
//

#import "ReservationService.h"
#import "AppDelegate.h"
#import "CoreDataStack.h"
#import "Reservation.h"
#import "Room.h"
#import "Guest.h"

@implementation ReservationService

+ (NSArray *)availableRoomsForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", endDate, startDate];
  
  request.predicate = predicate;
  NSError *fetchError;
  NSArray *results = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:request error:&fetchError];
  
  NSMutableArray *badRooms = [[NSMutableArray alloc] init];
  for (Reservation *reservation in results) {
    [badRooms addObject:reservation.room];
  }
  
  NSFetchRequest *finalRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
  NSPredicate *finalPredicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", badRooms];
  finalRequest.predicate = finalPredicate;
  
  NSError *finalError;
  
  NSArray *finalResults = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:finalRequest error:&finalError];
  
  if(finalError) {
    return nil;
  }
  return finalResults;
}

+ (NSFetchedResultsController *)fetchControllerAvailableRoomsForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", endDate, startDate];
  
  request.predicate = predicate;
  
  NSError *fetchError;
  NSArray *results = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:request error:&fetchError];
  
  
  
  NSMutableArray *badRooms = [[NSMutableArray alloc] init];
  for (Reservation *reservation in results) {
    [badRooms addObject:reservation.room];
  }
  
  NSFetchRequest *finalRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
  NSPredicate *finalPredicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", badRooms];
  finalRequest.predicate = finalPredicate;
  
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Room" ascending:true];
  NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
  [finalRequest setSortDescriptors:sortDescriptors];
  
  NSError *finalError;
  
  NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:finalRequest managedObjectContext:appDelegate.coreDataStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
  
  BOOL success = [controller performFetch:&finalError];
  
  if(!success) {
    return nil;
  }
  
  return controller;
}


+ (void)createReservationforGuest:(Guest *)guest inRoom:(Room *)room fromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  Reservation *newReservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:appDelegate.coreDataStack.managedObjectContext];
  
  newReservation.room = room;
  newReservation.guest = guest;
  newReservation.startDate = startDate;
  newReservation.endDate = endDate;
  
  NSError *saveError;
  BOOL result = [appDelegate.coreDataStack.managedObjectContext save:&saveError];
  if (!result) {
    NSLog(@" %@",saveError.localizedDescription);
  }

}

+ (NSArray *)getAllReservations {
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  
  NSError *fetchError;
  NSArray *results = [appDelegate.coreDataStack.managedObjectContext executeFetchRequest:request error:&fetchError];
  
  if(fetchError) {
    return nil;
  }
  return results;
}

@end