//
//  LSIWeatherForecast.h
//  DailyWeather
//
//  Created by Kenneth Jones on 12/2/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForecast : NSObject

- (instancetype)initWithTime:(NSDate *)aTime
                     summary:(NSString *)aSummary
                        icon:(NSString *)aIcon
           precipProbability:(double)aPrecipProbability
             precipIntensity:(double)aPrecipIntensity
                 temperature:(double)aTemperature
         apparentTemperature:(double)aApparentTemperature
                    humidity:(double)aHumidity
                    pressure:(double)aPressure
                   windSpeed:(double)aWindSpeed
                 windBearing:(double)aWindBearing
                     uvIndex:(double)aUVIndex;

- (nullable instancetype)initWithDictionary:(NSDictionary *)aDictionary;

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
@property (nonatomic, readonly) double windBearing;
@property (nonatomic, readonly) double uvIndex;

@property (nonatomic, readonly, copy) NSDictionary *dictionaryValue;

@end

NS_ASSUME_NONNULL_END
