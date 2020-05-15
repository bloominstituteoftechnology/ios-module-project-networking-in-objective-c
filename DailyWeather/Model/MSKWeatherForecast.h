//
//  MSKWeatherForecast.h
//  DailyWeather
//
//  Created by Lambda_School_Loaner_268 on 5/14/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSIWeatherIcons.h"
#import "LSICardinalDirection.h"
@class MSKCurrentForecast;
@class MSKDailyForecast;
@class MSKHourlyForecast;
@class MSKWeatherForecast;

NS_ASSUME_NONNULL_BEGIN
// MARK: - Model Object

// Not partsing out the nested objects. Otherwise builds. Moving to Networing
@interface MSKWeatherForecast : NSObject
@property MSKCurrentForecast *currentForecast;
@property NSMutableArray *hourlyArray;
@property MSKDailyForecast *dailyForecast;
@property MSKHourlyForecast *houlyForecast;
-(instancetype)initWithMSKCurrentForecast:(MSKCurrentForecast *) currentForcast
                            DailyForecast:(MSKDailyForecast *) dailyForecast
                            HourlyForcast:(MSKHourlyForecast *) hourlyForecast;
-(instancetype)initFromDict:(NSDictionary*) dict;
@end
// MARK: - CurrentWeather
@interface MSKCurrentForecast : NSObject
@property (nonatomic, nullable, assign) NSNumber *time;
@property (nonatomic, nullable, copy) NSString *summary;
@property (nonatomic, nullable, copy) NSString *icon;
@property (nonatomic, nullable, assign) NSNumber *precipIntensity;
@property (nonatomic, nullable, assign) NSNumber *precipProbability;
@property (nonatomic, nullable, assign) NSNumber *temperature;
@property (nonatomic, nullable, assign) NSNumber *apparentTemperature;
@property (nonatomic, nullable, assign) NSNumber *humidity;
@property (nonatomic, nullable, assign) NSNumber *pressure;
@property (nonatomic, nullable, assign) NSNumber *windSpeed;
@property (nonatomic, nullable, assign) NSNumber *windBearing;
@property (nonatomic, nullable, assign) NSNumber *uvIndex;
- (instancetype)initWithTime:(NSNumber *) time
                     summary:(NSString *) summary
                        icon:(NSString *) icon
             precipIntensity:(NSNumber *) precipintensity
           precipProbability:(NSNumber *) precipProbability
                 temperature:(NSNumber *) temperature
         apparentTemperature:(NSNumber *) apparentTemperature
                    humidity:(NSNumber *) humidity
                    pressure:(NSNumber *) pressure
                   windSpeed:(NSNumber *) windSpeed
                 windBearing:(NSNumber *) windBearing
                     uvIndex:(NSNumber *) uvIndex;

- (instancetype)initWithDict:(NSDictionary *) dictionary;
@end
@interface MSKDailyForecast : NSObject
@property (nonatomic, nullable, assign) NSNumber *time;
@property (nonatomic, nullable, copy) NSString *summary;
@property (nonatomic, nullable, copy) NSString *icon;
@property (nonatomic, nullable, assign) NSNumber *precipIntensity;
@property (nonatomic, nullable, assign) NSNumber *precipProbability;
@property (nonatomic, nullable, assign) NSString *precipType;
@property (nonatomic, nullable, assign) NSNumber *temperatureLow;
@property (nonatomic, nullable, assign) NSNumber *temperatureHigh;
@property (nonatomic, nullable, assign) NSNumber *apparentTemperature;
@property (nonatomic, nullable, assign) NSNumber *humidity;
@property (nonatomic, nullable, assign) NSNumber *pressure;
@property (nonatomic, nullable, assign) NSNumber *windSpeed;
@property (nonatomic, nullable, assign) NSNumber *windBearing;
@property (nonatomic, nullable, assign) NSNumber *uvIndex;
- (instancetype)initWithTime:(NSNumber *) time
                     summary:(NSString *) summary
                        icon:(NSString *) icon
             precipIntensity:(NSNumber *) precipintensity
           precipProbability:(NSNumber *) precipProbability
                  precipType:(NSString *) precipType
                 temperatureLow:(NSNumber *) temperatureLow
             temperatureHigh:(NSNumber*) temperatureHigh
         apparentTemperature:(NSNumber *) apparentTemperature
                    humidity:(NSNumber *) humidity
                    pressure:(NSNumber *) pressure
                   windSpeed:(NSNumber *) windSpeed
                 windBearing:(NSNumber *) windBearing
                     uvIndex:(NSNumber *) uvIndex;
- (instancetype)initWithDict:(NSDictionary *) dictionary;
@end
// MARK: - Hourly Weather
@interface MSKHourlyForecast : NSObject
@property (nonatomic, nullable, assign) NSNumber *time;
@property (nonatomic, nullable, copy) NSString *summary;
@property (nonatomic, nullable, copy) NSString *icon;
@property (nonatomic, nullable, assign) NSNumber *precipIntensity;
@property (nonatomic, nullable, assign) NSNumber *precipProbability;
@property (nonatomic, nullable, assign) NSNumber *temperature;
@property (nonatomic, nullable, assign) NSString *precipType;
@property (nonatomic, nullable, assign) NSNumber *temperatureLow;
@property (nonatomic, nullable, assign) NSNumber *temperatureHigh;
@property (nonatomic, nullable, assign) NSNumber *apparentTemperature;
@property (nonatomic, nullable, assign) NSNumber *humidity;
@property (nonatomic, nullable, assign) NSNumber *pressure;
@property (nonatomic, nullable, assign) NSNumber *windSpeed;
@property (nonatomic, nullable, assign) NSNumber *windBearing;
@property (nonatomic, nullable, assign) NSNumber *uvIndex;
- (instancetype)initWithTime:(NSNumber *) time
                     summary:(NSString *) summary
                        icon:(NSString *) icon
             precipIntensity:(NSNumber *) precipintensity
           precipProbability:(NSNumber *) precipProbability
                  precipType:(NSString *) precipType
              temperatureLow:(NSNumber *) temperatureLow
             temperatureHigh:(NSNumber *) temperatureHigh
         apparentTemperature:(NSNumber *) apparentTemperature
                    humidity:(NSNumber *) humidity
                    pressure:(NSNumber *) pressure
                   windSpeed:(NSNumber *) windSpeed
                 windBearing:(NSNumber *) windBearing
                     uvIndex:(NSNumber *) uvIndex;
- (instancetype)initWithDict:(NSDictionary *) dictionary;
@end


NS_ASSUME_NONNULL_END
