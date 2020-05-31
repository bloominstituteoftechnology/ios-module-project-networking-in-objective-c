//
//  LSIDailyForecast.h
//  DailyWeather
//
//  Created by Sal B Amer on 5/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//
/*
 LSIDailyForecas
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIDailyForecast : NSObject

- (instancetype)initWithTime:(NSDate *)time
            summary:(NSString *)summary
               icon:(NSString *)icon
        sunriseTime:(NSNumber *)sunriseTime
         sunsetTime:(NSNumber *)sunsetTime
    precipIntensity:(NSNumber *)precipIntensity
  precipProbability:(NSNumber *)precipProbability
         precipType:(NSString *)precipType
    temperatureHigh:(NSNumber *)temperatureHigh
     temperatureLow:(NSNumber *)temperatureLow
apparentTemperature:(NSNumber *)apparentTemperature
           humidity:(NSNumber *)humidity
           pressure:(NSNumber *)pressure
          windSpeed:(NSNumber *)windSpeed
        windBearing:(NSNumber *)windBearing
            uvIndex:(NSNumber *)uvIndex;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;


@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly, copy) NSString *summary;
@property (nonatomic, readonly, copy) NSString *icon;
@property (nonatomic, readonly) NSNumber *sunriseTime;
@property (nonatomic, readonly) NSNumber *sunsetTime;
@property (nonatomic, readonly) NSNumber *precipIntensity;
@property (nonatomic, readonly) NSNumber *precipProbability;
@property (nonatomic, readonly, copy) NSString *precipType; //rain, snow,seet
@property (nonatomic, readonly) NSNumber *temperatureHigh;
@property (nonatomic, readonly) NSNumber *temperatureLow;
@property (nonatomic, readonly) NSNumber *apparentTemperature;
@property (nonatomic, readonly) NSNumber *humidity;
@property (nonatomic, readonly) NSNumber *pressure;
@property (nonatomic, readonly) NSNumber *windSpeed;
@property (nonatomic, readonly) NSNumber *windBearing;
@property (nonatomic, readonly) NSNumber *uvIndex;


@end

NS_ASSUME_NONNULL_END
