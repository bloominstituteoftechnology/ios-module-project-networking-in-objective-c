//
//  LSIWeatherForcast.m
//  DailyWeather
//
//  Created by Bradley Diroff on 6/10/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForcast : NSObject

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly, nullable) NSString *summary;
@property (nonatomic, readonly, nullable) NSString *icon;
@property (nonatomic, readonly, nullable) NSNumber *precipProbability;
@property (nonatomic, readonly, nullable) NSNumber *precipIntensity;
@property (nonatomic, readonly, nullable) NSNumber *temperature;
@property (nonatomic, readonly, nullable) NSNumber *apparentTemperature;
@property (nonatomic, readonly, nullable) NSNumber *humidity;
@property (nonatomic, readonly, nullable) NSNumber *pressure;
@property (nonatomic, readonly, nullable) NSNumber *windSpeed;
@property (nonatomic, readonly, nullable) NSNumber *windBearing;
@property (nonatomic, readonly, nullable) NSNumber *uvIndex;

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(NSNumber *)precipProbability
             precipIntensity:(NSNumber *)precipIntensity
                 temperature:(NSNumber *)temperature
         apparentTemperature:(NSNumber *)apparentTemperature
                    humidity:(NSNumber *)humidity
                    pressure:(NSNumber *)pressure
                   windSpeed:(NSNumber *)windSpeed
                 windBearing:(NSNumber *)windBearing
                     uvIndex:(NSNumber *)uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
