//
//  LSIWeatherForcast.h
//  DailyWeather
//
//  Created by Jorge Alvarez on 3/18/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForcast : NSObject

@property (nonatomic, readonly) NSDate *time; // Required
@property (nonatomic, readonly, copy) NSString *summary; // ?
@property (nonatomic, readonly, copy) NSString *icon; // ?
@property (nonatomic, readonly) double precipProbablity; // ?
@property (nonatomic, readonly) double precipIntensity; // ?
@property (nonatomic, readonly) double temperature; // ?
@property (nonatomic, readonly) double apparentTemperature; // ?
@property (nonatomic, readonly) double humidity; // ?
@property (nonatomic, readonly) double pressure; // ?
@property (nonatomic, readonly) double windSpeed; // ?
@property (nonatomic, readonly) double windBearing; // ?
@property (nonatomic, readonly) int uvIndex; // ?

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(double)precipProbability
             precipIntensity:(double)precipIntensity
                 temperature:(double)temperature
         apparentTemperature:(double)apparentTemperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(double)windBearing
                     uvIndex:(int)uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
