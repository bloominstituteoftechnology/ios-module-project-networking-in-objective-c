//
//  LSIWeatherForecast.h
//  DailyWeather
//
//  Created by Chris Gonzales on 4/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSICurrentForecast;
@class LSIDailyForecast;
@class LSIHourlyForecast;

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForecast : NSObject

@property LSICurrentForecast *current;
@property NSArray<LSIDailyForecast *> *daily;
@property NSArray<LSIHourlyForecast *> *hourly;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
