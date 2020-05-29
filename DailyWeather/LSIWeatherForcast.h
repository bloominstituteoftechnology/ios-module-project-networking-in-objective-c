//
//  LSIWeatherForcast.h
//  DailyWeather
//
//  Created by Sal B Amer on 5/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
 
@class LSICurrentWeather;
@class LSIDailyForecast;
@class LSIHourlyForecast;

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForcast : NSObject

//parse from weather.json

- (instancetype)initWithLatitude:(double)latitude
                       longitude:(double)longitude
                        timezone:(NSString *)timezone
                 currentForecast:(LSICurrentWeather *)currently
                   dailyForecast:(NSArray<LSIDailyForecast *> *)daily
                  hourlyForecast:(NSArray<LSIHourlyForecast *> *)hourly NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;
@property (nonatomic, readonly, copy) NSString *timezone;

@property (nonatomic, readonly) LSICurrentWeather *currently;
@property (nonatomic, readonly, copy) NSArray<LSIDailyForecast *> *daily;
@property (nonatomic, readonly, copy) NSArray<LSIHourlyForecast *> *hourly;

@end

NS_ASSUME_NONNULL_END
