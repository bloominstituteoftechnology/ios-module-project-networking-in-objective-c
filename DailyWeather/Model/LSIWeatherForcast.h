//
//  LSIWeatherForcast.h
//  DailyWeather
//
//  Created by Matthew Martindale on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSICurrentForecast;
@class LSIDailyForecast;
@class LSIHourlyForecast;

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForcast : NSObject

- (instancetype)initWithLatitude: (double)latitude
                       longitude: (double)longitude
                        timezone: (NSString *)timezone
                 currentForecast: (LSICurrentForecast *)currently
                   dailyForecast: (NSArray<LSIDailyForecast *> *)daily
                  hourlyForecast: (NSArray<LSIHourlyForecast *> *)hourly;

- (nullable instancetype)initWithDictionary: (NSDictionary *)dictionary;

@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;
@property (nonatomic, readonly, copy) NSString *timezone;
@property (nonatomic, readonly) LSICurrentForecast *currently;
@property (nonatomic, readonly, copy) NSArray<LSIDailyForecast *> *daily;
@property (nonatomic, readonly, copy) NSArray<LSIHourlyForecast *> *hourly;


@end

NS_ASSUME_NONNULL_END
