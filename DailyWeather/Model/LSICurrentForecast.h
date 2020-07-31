//
//  LSICurrentForecast.h
//  DailyWeather
//
//  Created by Chad Parker on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSICurrentForecast : NSObject

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly, copy) NSString *summary;
@property (nonatomic, readonly, copy) NSString *icon;
@property (nonatomic, readonly) double precipProbability;
@property (nonatomic, readonly) double precipIntensity;
@property (nonatomic, readonly) double temperature;
@property (nonatomic, readonly) double apparentTemperature;
@property (nonatomic, readonly) double humidity;
@property (nonatomic, readonly) double pressure;
@property (nonatomic, readonly) double windSpeed;
@property (nonatomic, readonly) int windBearing;
@property (nonatomic, readonly) int uvIndex;

- (instancetype)init NS_UNAVAILABLE;

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
                 windBearing:(int)windBearing
                     uvIndex:(int)uvIndex NS_DESIGNATED_INITIALIZER;

- (nullable instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
