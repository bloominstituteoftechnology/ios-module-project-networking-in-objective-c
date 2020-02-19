//
//  LSICardinalDirection.h
//
//  Created by Paul Solt on 2/17/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSICardinalDirection : NSObject

/// Returns a direction N (North) for 360 or 0
/// Only supports positive angles
+ (NSString *)directionForHeading:(double)bearing;

@end

NS_ASSUME_NONNULL_END
