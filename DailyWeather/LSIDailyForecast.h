//
//  LSIDailyForecast.h
//  DailyWeather
//
//  Created by Karen Rodriguez on 5/12/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIDailyForecast : NSObject

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly, copy) NSString *summary; // optional
@property (nonatomic, readonly, copy) NSString *icon; // optional
@property (nonatomic, readonly) NSNumber *sunriseTime; // optional NEW
@property (nonatomic, readonly) NSNumber *sunsetTime; // optional NEW
@property (nonatomic, readonly) NSNumber *precipProbability; // optional
@property (nonatomic, readonly) NSNumber *precipIntensity; // optional
@property (nonatomic, readonly, copy) NSString *precipType; // optional NEW
@property (nonatomic, readonly) NSNumber *temperatureLow; // optional NEW
@property (nonatomic, readonly) NSNumber *temperatureHigh; // optional NEW
@property (nonatomic, readonly) NSNumber *apparentTemperature; // optional
@property (nonatomic, readonly) NSNumber *humidity; // optional
@property (nonatomic, readonly) NSNumber *pressure; // optional
@property (nonatomic, readonly) NSNumber *windSpeed; // optional
@property (nonatomic, readonly) NSNumber *windBearing; // optional
@property (nonatomic, readonly) NSNumber *uvIndex; // optional

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
                 sunriseTime:(NSNumber *)sunriseTime
                  sunsetTime:(NSNumber *)sunsetTime
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
