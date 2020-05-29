//
//  LSIHourlyForecast.h
//  DailyWeather
//
//  Created by Sal B Amer on 5/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIHourlyForecast : NSObject

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, copy, readonly) NSString *summary;
@property (nonatomic, copy, readonly) NSString *icon;
@property (nonatomic, readonly) NSNumber *precipProbability;
@property (nonatomic, readonly) NSNumber *precipIntensity;
@property (nonatomic, readonly) NSString *precipType;
@property (nonatomic, readonly) NSNumber *temperatureLow;
@property (nonatomic, readonly) NSNumber *temperatureHigh;
@property (nonatomic, readonly) NSNumber *apparentTemperature;
@property (nonatomic, readonly) NSNumber *humidity;
@property (nonatomic, readonly) NSNumber *pressure;
@property (nonatomic, readonly) NSNumber *windSpeed;
@property (nonatomic, readonly) NSNumber *windBearing;
@property (nonatomic, readonly) NSNumber *uvIndex;

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
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

//- (instancetype)initWithTime:(NSDate *)time
//                     summary:(NSString *)summary
//                        icon:(NSString *)icon
//             precipIntensity:(double)precipIntensity
//           precipProbability:(double)precipProbability
//                  precipType:(NSString *)precipType
//                 temperature:(double)temperature
//         apparentTemperature:(double)apparentTemperature
//                    humidity:(double)humidity
//                    pressure:(double)pressure
//                   windSpeed:(double)windSpeed
//                 windBearing:(double)windBearing
//                     uvIndex:(double)uvIndex NS_DESIGNATED_INITIALIZER;
//
//- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;
//
//@property (nonatomic, readonly) NSDate *time;
//@property (nonatomic, readonly, copy) NSString *summary;
//@property (nonatomic, readonly, copy) NSString *icon;
//@property (nonatomic, readonly) double precipIntensity;
//@property (nonatomic, readonly) double precipProbability;
//@property (nonatomic, readonly, copy) NSString *precipType;
//@property (nonatomic, readonly) double temperature;
//@property (nonatomic, readonly) double apparentTemperature;
//@property (nonatomic, readonly) double humidity;
//@property (nonatomic, readonly) double pressure;
//@property (nonatomic, readonly) double windSpeed;
//@property (nonatomic, readonly) double windBearing;
//@property (nonatomic, readonly) double uvIndex;

//@end

NS_ASSUME_NONNULL_END
