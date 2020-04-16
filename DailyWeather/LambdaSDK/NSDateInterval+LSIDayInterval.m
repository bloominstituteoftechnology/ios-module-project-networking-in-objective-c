//
//  NSDateInterval+LSIDayInterval.m
//  Quakes-Objc
//
//  Created by Nick Nguyen on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "NSDateInterval+LSIDayInterval.h"

@implementation NSDateInterval (LSIDayInterval)


+ (NSDateInterval *)lsi_dateIntervalByAddingDays:(NSInteger)days {
    return [self lsi_dateIntervalByAddingDays:days toDate: [[NSDate alloc] init]];
}
+ (NSDateInterval *)lsi_dateIntervalByAddingDays:(NSInteger)days toDate:(NSDate *)date {
    
    NSDate *startDate = nil ;
    NSDate *endDate = nil;
    if (days >= 0) {
        startDate = date;
        endDate = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay value:days toDate:startDate options:0];
    } else {
        endDate = date;
        startDate = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay  value:days toDate:endDate options:0];
    }
    return [[NSDateInterval alloc] initWithStartDate:startDate endDate:endDate];
    
    
}

@end
