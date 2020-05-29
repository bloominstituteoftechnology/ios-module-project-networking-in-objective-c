//
//  CurrentForecast.h
//  DailyWeather
//
//  Created by Jessie Ann Griffin on 5/26/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForcast.h"

NS_ASSUME_NONNULL_BEGIN

@interface CurrentForecast : LSIWeatherForcast

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(int)precipProbability
             precipIntensity:(int)precipIntensity
                 temperature:(double)temperature
                    humidity:(double)humidity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(NSString *)windBearing
                     uvIndex:(int)uvIndex;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly, copy) NSString *summary;
@property (nonatomic, readonly, copy) NSString *icon;
@property (nonatomic, readonly) int precipProbability;
@property (nonatomic, readonly) int precipIntensity;
@property (nonatomic, readonly) double temperature;
@property (nonatomic, readonly) double humidity;
@property (nonatomic, readonly) double pressure;
@property (nonatomic, readonly) double windSpeed;
@property (nonatomic, readonly, copy) NSString *windBearing;
@property (nonatomic, readonly) int uvIndex;

@end

NS_ASSUME_NONNULL_END
