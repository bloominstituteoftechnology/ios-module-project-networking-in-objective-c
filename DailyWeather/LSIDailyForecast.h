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
@property (nonatomic, readonly) NSDate *sunriseTime; // Optional
@property (nonatomic, readonly) NSDate *sunsetTime; // Optional
@property (nonatomic, readonly) NSNumber *precipProbablity; // Optional
@property (nonatomic, readonly) NSNumber *precipIntensity; // Optional
@property (nonatomic, readonly, copy) NSString *precipType; // Optional
@property (nonatomic, readonly) NSNumber *temperatureLow; // Optional
@property (nonatomic, readonly) NSNumber *temperatureHigh; // Optional
@property (nonatomic, readonly) NSNumber *apparentTemperature; // Optional HIGH
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
