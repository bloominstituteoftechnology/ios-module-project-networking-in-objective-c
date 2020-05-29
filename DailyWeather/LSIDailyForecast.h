//
//  LSIDailyForecast.h
//  DailyWeather
//
//  Created by Sal B Amer on 5/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//
/*
 LSIDailyForecast

 time (unix time)
 summary
 icon
 sunriseTime
 sunsetTime
 precipProbability
 precipIntensity
 precipType ("rain", "snow", or "sleet", or nil)
 temperatureLow
 temperatureHigh
 apparentTemperature (Feels like)
 humidity
 pressure
 windSpeed
 windBearing
 uvIndex

 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIDailyForecast : NSObject

- (instancetype)initWithTime:(NSDate *)time
            summary:(NSString *)summary
               icon:(NSString *)icon
        sunriseTime:(NSDate *)sunriseTime
         sunsetTime:(NSDate *)sunsetTime
  precipProbability:(double)precipProbability
    precipIntensity:(double)precipIntensity
         precipType:(NSString *)precipType
     temperatureLow:(double)temperatureLow
    temperatureHigh:(double)temperatureHigh
apparentTemperature:(double)apparentTemperature
           humidity:(double)humidity
           pressure:(double)pressure
          windSpeed:(double)windSpeed
        windBearing:(double)windBearing
            uvIndex:(double)uvIndex NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;


@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly, copy) NSString *summary;
@property (nonatomic, readonly, copy) NSString *icon;
@property (nonatomic, readonly) NSDate *sunriseTime;
@property (nonatomic, readonly) NSDate *sunsetTime;
@property (nonatomic, readonly) double precipProbability;
@property (nonatomic, readonly) double precipIntensity;
@property (nonatomic, readonly, copy) NSString *precipType; //rain, snow,seet
@property (nonatomic, readonly) double temperatureLow;
@property (nonatomic, readonly) double temperatureHigh;
@property (nonatomic, readonly) double apparentTemperature;
@property (nonatomic, readonly) double humidity;
@property (nonatomic, readonly) double pressure;
@property (nonatomic, readonly) double windSpeed;
@property (nonatomic, readonly) double windBearing;
@property (nonatomic, readonly) double uvIndex;


@end

NS_ASSUME_NONNULL_END
