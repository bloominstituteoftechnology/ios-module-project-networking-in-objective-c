//
//  LSIHourlyForecast.h
//  DailyWeather
//
//  Created by denis cedeno on 5/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIHourlyForecast : NSObject

@property (nonatomic, readonly)NSDate *time;
@property (nonatomic, readonly, copy)NSString *summary;
@property (nonatomic, readonly, copy)NSString *icon;
@property (nonatomic, readonly)NSNumber *precipProbability;
@property (nonatomic, readonly)NSNumber *precipIntensity;
@property (nonatomic, readonly, copy)NSString *precipType;
@property (nonatomic, readonly)NSNumber *temperatureLow;
@property (nonatomic, readonly)NSNumber *temperatureHigh;
@property (nonatomic, readonly)NSNumber *apparentTemperature;
@property (nonatomic, readonly)NSNumber *humidity;
@property (nonatomic, readonly)NSNumber *pressure;
@property (nonatomic, readonly)NSNumber *windSpeed;
@property (nonatomic, readonly)NSNumber *windBearing;
@property (nonatomic, readonly)NSNumber *uvIndex;

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

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
