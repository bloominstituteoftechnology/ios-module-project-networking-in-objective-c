//
//  LSIHourlyForecast.h
//  DailyWeather
//
//  Created by Ufuk Türközü on 16.04.20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIHourlyForecast : NSObject

@property (nonatomic, readonly, copy) NSDate *time;
@property (nonatomic, readonly,copy) NSString *icon;
@property (nonatomic, readonly) double temperatureHigh;
@property (nonatomic, readonly) double temperatureLow;
@property (nonatomic, readonly) double precipIntensity;
@property (nonatomic, readonly) double precipProbability;
@property (nonatomic, readonly,copy) NSString *percipType;
@property (nonatomic, readonly) double apparentTemperature;
@property (nonatomic, readonly) double humidity;
@property (nonatomic, readonly) double pressure;
@property (nonatomic, readonly) double windSpeed;
@property (nonatomic, readonly) double windBearing;
@property (nonatomic, readonly) double uvIndex;

- (instancetype)initWithTime:(NSDate *)time
                        icon:(NSString *)icon
             temperatureHigh:(double)temperatureHigh
             temperatureLow:(double)temperatureLow
             precipIntensity:(double)precipIntensity
           precipProbability:(double)precipProbability
                  percipType:(NSString *)temperature
         apparentTemperature:(double)apparentTemperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(double)windBearing
                     uvIndex:(double)uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
