//
//  LSIDailyForecast.h
//  DailyWeather
//
//  Created by Rob Vance on 11/17/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIDailyForecast : NSObject

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly, copy) NSString *summary;
@property (nonatomic, readonly, copy) NSString *icon;
@property (nonatomic, readonly) NSDate *sunriseTime;
@property (nonatomic, readonly) NSDate *sunsetTime;
@property (nonatomic, readonly) double precipIntensity;
@property (nonatomic, readonly) double precipProbability;
@property (nonatomic, readonly, copy) NSString *precipType;
@property (nonatomic, readonly) double temperatureLow;
@property (nonatomic, readonly) double temperatureHigh;
@property (nonatomic, readonly) double apparentTemperature;
@property (nonatomic, readonly) double humidity;
@property (nonatomic, readonly) double pressure;
@property (nonatomic, readonly) double windSpeed;
@property (nonatomic, readonly) double windBearing;
@property (nonatomic, readonly) double uvIndex;

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
                 sunriseTime:(NSDate *)sunriseTime
                  sunsetTime:(NSDate *)sunsetTime
            precipInstensity:(double)precipIntensity
           precipProbability:(double)precipProbability
                  precipType:(NSString *)precipType
              temperatureLow:(double)temperatureLow
             temperatureHigh:(double)temperatureHigh
         apperentTemperature:(double)apperentTemperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(double)windBearing
                     uvIndex:(double)uvIndex NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
