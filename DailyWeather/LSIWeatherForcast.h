//
//  LSIWeatherForcast.h
//  DailyWeather
//
//  Created by Sal B Amer on 5/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 {
     "time": 1581003354,
     "summary": "Clear",
     "icon": "clear-day",
     "nearestStormDistance": 17,
     "nearestStormBearing": 333,
     "precipIntensity": 0,
     "precipProbability": 0,
     "temperature": 48.35,
     "apparentTemperature": 47.4,
     "dewPoint": 41.38,
     "humidity": 0.77,
     "pressure": 1023.2,
     "windSpeed": 3.45,
     "windGust": 4.44,
     "windBearing": 24,
     "cloudCover": 0.02,
     "uvIndex": 0,
     "visibility": 10,
     "ozone": 280.8
 }
 
REQUIRED
 time (unix time)
 summary
 icon
 precipProbability
 precipIntensity
 temperature
 apparentTemperature (Feels like)
 humidity
 pressure
 windSpeed
 windBearing
 uvIndex


 */

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForcast : NSObject

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(NSNumber *)precipProbability
              recipIntensity:(NSNumber *)precipIntensity
                 temperature:(NSNumber *)temperature
         apparentTemperature:(NSNumber *)apparentTemperature
                    humidity:(NSNumber *)humidity
                    pressure:(NSNumber *)pressure
                   windSpeed:(NSNumber *)windSpeed
                 windBearing:(NSNumber *)windBearing
                     uvIndex:(NSNumber *)uvIndex;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

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



@end

NS_ASSUME_NONNULL_END
