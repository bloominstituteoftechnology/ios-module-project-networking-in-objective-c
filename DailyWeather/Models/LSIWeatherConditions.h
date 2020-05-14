//
//  LSIWeatherConditions.h
//  DailyWeather
//
//  Created by Shawn Gee on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherConditions : NSObject

@property (nonatomic, readonly) NSDate *time; // UNIX time
@property (nonatomic, readonly, nullable, copy) NSString *summary; // A human-readable text summary
@property (nonatomic, readonly, nullable, copy) NSString *iconString; // clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night
@property (nonatomic, readonly, nullable) NSNumber *precipProbability; // double: The probability of precipitation occurring, between 0 and 1, inclusive.
@property (nonatomic, readonly, nullable) NSNumber *precipIntensity; // double: inches of liquid water per hour
@property (nonatomic, readonly, nullable, copy) NSString *precipType; // "rain", "snow", or "sleet"
@property (nonatomic, readonly, nullable) NSNumber *humidity; // double: The relative humidity, between 0 and 1, inclusive
@property (nonatomic, readonly, nullable) NSNumber *pressure; // double: millibars
@property (nonatomic, readonly, nullable) NSDate *sunriseTime; // UNIX time
@property (nonatomic, readonly, nullable) NSDate *sunsetTime; // UNIX time
@property (nonatomic, readonly, nullable) NSNumber *temperature; // degreees F
@property (nonatomic, readonly, nullable) NSNumber *apparentTemperature; // degreees F
@property (nonatomic, readonly, nullable) NSNumber *apparentTemperatureHigh; // degreees F
@property (nonatomic, readonly, nullable) NSNumber *temperatureLow; // degreees F
@property (nonatomic, readonly, nullable) NSNumber *temperatureHigh; // degreees F
@property (nonatomic, readonly, nullable) NSNumber *windSpeed; // double: mph
@property (nonatomic, readonly, nullable) NSNumber *windBearing; // int: The direction that the wind is coming from in degrees, with true north at 0° and progressing clockwise.
@property (nonatomic, readonly, nullable) NSNumber *uvIndex; // int


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
