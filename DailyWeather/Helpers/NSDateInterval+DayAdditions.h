//
//  NSDateInterval+DayAdditions.h
//  DailyWeather
//
//  Created by Claudia Maciel on 7/30/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateInterval (DayAdditions)

+ (NSDateInterval *)lsi_dateIntervalByAddingDays:(NSInteger)days;
+ (NSDateInterval *)lsi_dateIntervalByAddingDays:(NSInteger)days toDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
