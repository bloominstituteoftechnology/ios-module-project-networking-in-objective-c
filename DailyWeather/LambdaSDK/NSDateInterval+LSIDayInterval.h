//
//  NSDateInterval+LSIDayInterval.h
//  Quakes-Objc
//
//  Created by Nick Nguyen on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// Category (like Swift Extension)
@interface NSDateInterval (LSIDayInterval)


// + = class method
//[NSDateInterval ourMethodName];

// [NSDateInterval ourMethodName];
// [NSDateInterval dateIntervalByAddingDays: -7]; // range from past week


// When we don't own the source code we need to make our method names unique
// Apple controls the implementation of NSDateInterval, if we both implement the same method,
// The objc runtime has a 50/50 chance of calling the wrong version which would behave differently (crash!)



// uses the current date as the end interval
+ (NSDateInterval *)lsi_dateIntervalByAddingDays:(NSInteger)days;
+ (NSDateInterval *)lsi_dateIntervalByAddingDays:(NSInteger)days toDate:(NSDate *)date;



@end

NS_ASSUME_NONNULL_END

