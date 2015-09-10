//
//  CoreDataStack.m
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/9/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

#import "CoreDataStack.h"
#import "Hotel.h"
#import "Room.h"

@implementation CoreDataStack

-(instancetype)init {
  self = [super init];
  if (self) {
    [self seedCoreDataIfNeeded];
  }
  return self;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
  // The directory the application uses to store the Core Data store file. This code uses a directory named "com.samwilskey.Hotel_Booker" in the application's documents directory.
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
  // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Hotel_Booker" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  
  // Create the coordinator and store
  
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Hotel_Booker.sqlite"];
  NSError *error = nil;
  NSString *failureReason = @"There was an error creating or loading the application's saved data.";
  if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    // Report any error we got.
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
    dict[NSLocalizedFailureReasonErrorKey] = failureReason;
    dict[NSUnderlyingErrorKey] = error;
    error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
    // Replace this with code to handle the error appropriately.
    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  
  return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
  // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
  if (_managedObjectContext != nil) {
    return _managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (!coordinator) {
    return nil;
  }
  _managedObjectContext = [[NSManagedObjectContext alloc] init];
  [_managedObjectContext setPersistentStoreCoordinator:coordinator];
  return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    NSError *error = nil;
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}

#pragma mark - Helper Methods
- (void)seedCoreDataIfNeeded {
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  
  NSError *fetchError;
  NSInteger count = [self.managedObjectContext countForFetchRequest:fetchRequest error:&fetchError];
  
  if (count == 0) {
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"hotels" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSError *jsonError;
    
    NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
    NSArray *hotels = [rootObject objectForKey:@"Hotels"];
    for(NSDictionary* jsonHotel in hotels) {
      Hotel *hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
      hotel.name = [jsonHotel objectForKey:@"name"];
      hotel.stars = [jsonHotel objectForKey:@"stars"];
      NSArray *rooms = [jsonHotel objectForKey:@"rooms"];
      for(NSDictionary* jsonRoom in rooms) {
        Room *room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
        room.number = [jsonRoom objectForKey:@"number"];
        room.beds = [jsonRoom objectForKey:@"beds"];
        room.rate = [jsonRoom objectForKey:@"rate"];
        
        [hotel addRoomsObject:room];
      }
      
      NSError *saveError;
      BOOL result = [self.managedObjectContext save:&saveError];
      if (!result) {
        NSLog(@" %@",saveError.localizedDescription);
      }
    }
  }
}


@end
