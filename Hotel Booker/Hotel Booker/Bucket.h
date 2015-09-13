//
//  Bucket.h
//  Hotel Booker
//
//  Created by Sam Wilskey on 9/13/15.
//  Copyright © 2015 Wilskey Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bucket : NSObject

@property (strong,nonatomic) Bucket *next;
@property (strong,nonatomic) NSString *key;
@property (strong,nonatomic) id value;

@end
