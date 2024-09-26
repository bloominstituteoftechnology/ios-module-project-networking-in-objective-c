//
//  LSIWeatherForecast.h
//  DailyWeather
//
//  Created by Mark Gerrior on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSICurrentWeather;
@class LSIDailyForecast;
@class LSIHourlyForecast;

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForecast : NSObject

@property (nonatomic, readonly) LSICurrentWeather *currently;
@property (nonatomic, readonly) LSIDailyForecast  *daily;
@property (nonatomic, readonly) LSIHourlyForecast *hourly;

- (instancetype)initWithCurrently:(LSICurrentWeather *)currently
                            daily:(LSIDailyForecast *)daily
                           hourly:(LSIHourlyForecast *)hourly;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
