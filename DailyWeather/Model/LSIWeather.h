//
//  LSIWeather.h
//  DailyWeather
//
//  Created by Kenneth Jones on 12/3/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSIWeatherForecast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeather : NSObject

- (instancetype)initWithWeather:(LSIWeatherForecast *)someWeather
                   dailyWeather:(NSArray<LSIDailyForecast *> *)someDailyWeather
                  hourlyWeather:(NSArray<LSIHourlyForecast *> *)someHourlyWeather;

- (nullable instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@property (nonatomic, readonly) LSIWeatherForecast *weather;
@property (nonatomic, readonly, copy) NSArray<LSIDailyForecast *> *dailyWeather;
@property (nonatomic, readonly, copy) NSArray<LSIHourlyForecast *> *hourlyWeather;

@end

NS_ASSUME_NONNULL_END
