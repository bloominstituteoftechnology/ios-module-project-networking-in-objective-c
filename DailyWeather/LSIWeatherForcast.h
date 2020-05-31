//
//  LSIWeatherForcast.h
//  DailyWeather
//
//  Created by Sal B Amer on 5/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
 
@class LSICurrentWeather;
@class LSIDailyForecast;
@class LSIHourlyForecast;

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForcast : NSObject


@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly, copy) NSString *summary;
@property (nonatomic, readonly, copy) NSString *icon;
@property (nonatomic, readonly) NSNumber *precipProbability;
@property (nonatomic, readonly) NSNumber *precipIntensity;
@property (nonatomic, readonly) NSNumber *temperature;
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
                 temperature:(NSNumber *)temperature
         apparentTemperature:(NSNumber *)apparentTemperature
                    humidity:(NSNumber *)humidity
                    pressure:(NSNumber *)pressure
                   windSpeed:(NSNumber *)windSpeed
                 windBearing:(NSNumber *)windBearing
                     uvIndex:(NSNumber *)uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

////parse from weather.json
//
//- (instancetype)initWithLatitude:(double)latitude
//                       longitude:(double)longitude
//                        timezone:(NSString *)timezone
//                 currentForecast:(LSICurrentWeather *)currently
//                   dailyForecast:(NSArray<LSIDailyForecast *> *)daily
//                  hourlyForecast:(NSArray<LSIHourlyForecast *> *)hourly NS_DESIGNATED_INITIALIZER;
//
//- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;
//
//@property (nonatomic, readonly) double latitude;
//@property (nonatomic, readonly) double longitude;
//@property (nonatomic, readonly, copy) NSString *timezone;
//
//@property (nonatomic, readonly) LSICurrentWeather *currently;
//@property (nonatomic, readonly, copy) NSArray<LSIDailyForecast *> *daily;
//@property (nonatomic, readonly, copy) NSArray<LSIHourlyForecast *> *hourly;

@end

NS_ASSUME_NONNULL_END
