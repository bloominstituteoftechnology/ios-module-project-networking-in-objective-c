//
//  LSIDailyForecast.h
//  DailyWeather
//
//  Created by Jorge Alvarez on 3/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// JSON shows ARRAY of LSIDailyForecast objects
@interface LSIDailyForecast : NSObject

// MARK: - Properties

@property (nonatomic, readonly) NSDate *time; // Required
@property (nonatomic, readonly, copy) NSString *summary; // Optional
@property (nonatomic, readonly, copy) NSString *icon; // Optional
@property (nonatomic, readonly) NSDate *sunriseTime; // NEW
@property (nonatomic, readonly) NSDate *sunsetTime; // NEW
@property (nonatomic, readonly) NSNumber *precipProbablity; // Optional
@property (nonatomic, readonly) NSNumber *precipIntensity; // Optional
@property (nonatomic, readonly, copy) NSString *precipType; // NEW
@property (nonatomic, readonly) NSNumber *temperatureLow; // NEW
@property (nonatomic, readonly) NSNumber *temperatureHigh; // NEW
@property (nonatomic, readonly) NSNumber *apparentTemperature; // Optional
@property (nonatomic, readonly) NSNumber *humidity; // Optional
@property (nonatomic, readonly) NSNumber *pressure; // Optional
@property (nonatomic, readonly) NSNumber *windSpeed; // Optional
@property (nonatomic, readonly) NSNumber *windBearing; // Optional
@property (nonatomic, readonly) NSNumber *uvIndex; // Optional

// MARK: - Methods

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
                 sunriseTime:(NSDate *)sunriseTime
                  sunsetTime:(NSDate *)sunsetTime
           precipProbability:(NSNumber *)precipProbability
             precipIntensity:(NSNumber *)precipIntensity
                  precipType:(NSString *)precipType
              temperatureLow:(NSNumber *)temperatureLow
             temperatureHigh:(NSNumber *)temperatureHigh
         apparentTemperature:(NSNumber *)apparentTemperature
                    humidity:(NSNumber *)humidity
                    pressure:(NSNumber *)pressure
                   windSpeed:(NSNumber *)windSpeed
                 windBearing:(NSNumber *)windBearing
                     uvIndex:(NSNumber *)uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END


/*
 {
     "time": 1580976000,
     "summary": "Clear throughout the day.",
     "icon": "clear-day",
     "sunriseTime": 1581001860,
     "sunsetTime": 1581039540,
     "moonPhase": 0.42,
     "precipIntensity": 0.0006,
     "precipIntensityMax": 0.0022,
     "precipIntensityMaxTime": 1581004560,
     "precipProbability": 0.13,
     "precipType": "rain",
     "temperatureHigh": 61.22,
     "temperatureHighTime": 1581030780,
     "temperatureLow": 47.02,
     "temperatureLowTime": 1581086700,
     "apparentTemperatureHigh": 60.72,
     "apparentTemperatureHighTime": 1581030780,
     "apparentTemperatureLow": 46.05,
     "apparentTemperatureLowTime": 1581087000,
     "dewPoint": 46.04,
     "humidity": 0.78,
     "pressure": 1021.8,
     "windSpeed": 3.82,
     "windGust": 7.02,
     "windGustTime": 1581035280,
     "windBearing": 320,
     "cloudCover": 0.06,
     "uvIndex": 4,
     "uvIndexTime": 1581020700,
     "visibility": 10,
     "ozone": 278.9,
     "temperatureMin": 46.82,
     "temperatureMinTime": 1580995260,
     "temperatureMax": 61.22,
     "temperatureMaxTime": 1581030780,
     "apparentTemperatureMin": 46.02,
     "apparentTemperatureMinTime": 1580997780,
     "apparentTemperatureMax": 60.72,
     "apparentTemperatureMaxTime": 1581030780
 }
 */
