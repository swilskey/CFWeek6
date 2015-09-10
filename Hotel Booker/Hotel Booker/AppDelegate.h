//
//  AppDelegate.h
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/7/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CoreDataStack;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) CoreDataStack *coreDataStack;
@end