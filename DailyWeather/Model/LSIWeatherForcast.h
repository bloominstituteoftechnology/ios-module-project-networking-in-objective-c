//
//  LSIWeatherForcast.h
//  DailyWeather
//
//  Created by Clayton Watkins on 9/23/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LSICurrentForecast;
@class LSIDailyWeather;
@class LSIHourlyForecast;

@interface LSIWeatherForcast : NSObject

@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;
@property (nonatomic, readonly, copy) NSString *timezone;

@property (nonatomic, readonly) LSICurrentForecast *currently;
@property (nonatomic, readonly, copy) NSArray<LSIDailyWeather *> *daily;
@property (nonatomic, readonly, copy) NSArray<LSIHourlyForecast *> *hourly;

- (instancetype)initWithLatitude:(double)latitude
                       longitude:(double)longitude
                        timezone:(NSString *)timezone
                 currentForecast:(LSICurrentForecast *)currently
                   dailyForecast:(NSArray<LSIDailyWeather *> *)daily
                  hourlyForecast:(NSArray<LSIHourlyForecast *> *)hourly NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;



@end

NS_ASSUME_NONNULL_END
