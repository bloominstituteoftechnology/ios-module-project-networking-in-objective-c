//
//  LSIHourlyForecast.h
//  DailyWeather
//
//  Created by Matthew Martindale on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIHourlyForecast : NSObject

- (instancetype)initWithTime:(NSDate *)time
            summary:(NSString *)summary
               icon:(NSString *)icon
  precipProbability:(int)precipProbability
    precipIntensity:(double)precipIntensity
         precipType:(NSString *)precipType
     temperatureLow:(double)temperatureLow
    temperatureHigh:(double)temperatureHigh
apparentTemperature:(double)apparentTemperature
           humidity:(double)humidity
           pressure:(double)pressure
          windSpeed:(double)windSpeed
        windBearing:(int)windBearing
            uvIndex:(int)uvIndex;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly, copy) NSString *summary;
@property (nonatomic, readonly, copy) NSString *icon;
@property (nonatomic, readonly) int precipProbability;
@property (nonatomic, readonly) double precipIntensity;
@property (nonatomic, readonly, copy) NSString *precipType;
@property (nonatomic, readonly) double temperatureLow;
@property (nonatomic, readonly) double temperatureHigh;
@property (nonatomic, readonly) double apparentTemperature;
@property (nonatomic, readonly) double humidity;
@property (nonatomic, readonly) double pressure;
@property (nonatomic, readonly) double windSpeed;
@property (nonatomic, readonly) int windBearing;
@property (nonatomic, readonly) int uvIndex;

@end

NS_ASSUME_NONNULL_END
