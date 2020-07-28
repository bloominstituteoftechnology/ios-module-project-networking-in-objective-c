//
//  LSICurrentForecast.h
//  DailyWeather
//
//  Created by Sean Acres on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSICurrentForecast : NSObject

- (instancetype)initWithTime:(NSDate *)time
                     summary:(nullable NSString *)summary
                        icon:(nullable NSString *)icon
           precipProbability:(nullable NSNumber *)precipProbability
             precipIntensity:(nullable NSNumber *)precipIntensity
                 temperature:(nullable NSNumber *)temperature
         apparentTemperature:(nullable NSNumber *)apparentTemperature
                    humidity:(nullable NSNumber *)humidity
                    pressure:(nullable NSNumber *)pressure
                   windSpeed:(nullable NSNumber *)windSpeed
                 windBearing:(nullable NSNumber *)windBearing
                     uvIndex:(nullable NSNumber *)uvIndex;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly, copy, nullable) NSString *summary;
@property (nonatomic, readonly, copy, nullable) NSString *icon;
@property (nonatomic, readonly, nullable) NSNumber *precipProbability;
@property (nonatomic, readonly, nullable) NSNumber *precipIntensity;
@property (nonatomic, readonly, nullable) NSNumber *temperature;
@property (nonatomic, readonly, nullable) NSNumber *apparentTemperature;
@property (nonatomic, readonly, nullable) NSNumber *humidity;
@property (nonatomic, readonly, nullable) NSNumber *pressure;
@property (nonatomic, readonly, nullable) NSNumber *windSpeed;
@property (nonatomic, readonly, nullable) NSNumber *windBearing;
@property (nonatomic, readonly, nullable) NSNumber *uvIndex;



@end

NS_ASSUME_NONNULL_END
