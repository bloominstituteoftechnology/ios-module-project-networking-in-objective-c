//
//  LSIWeatherForecast.h
//  DailyWeather
//
//  Created by scott harris on 4/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SAHHourlyForecast;
@class SAHCurrentForecast;
@class SAHDailyForecast;

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForecast : NSObject

@property SAHCurrentForecast *currentForecast;
@property NSArray<SAHDailyForecast *> *dailyForecast;
@property NSArray<SAHHourlyForecast *> *hourlyForecast;

- (instancetype)initWithCurrentForecast:(SAHCurrentForecast *)currentForecast dailyForecasts:(NSArray<SAHDailyForecast *> *)dailyForecasts hourlyForecasts:(NSArray<SAHHourlyForecast *> *)hourlyForecasts;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;



@end

NS_ASSUME_NONNULL_END
