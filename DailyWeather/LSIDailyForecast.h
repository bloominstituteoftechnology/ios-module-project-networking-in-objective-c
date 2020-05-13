//
//  LSIDailyForecast.h
//  DailyWeather
//
//  Created by Wyatt Harrell on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIDailyForecast : NSObject

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly, nullable, copy) NSString *summary;
@property (nonatomic, readonly, nullable, copy) NSString *icon;
@property (nonatomic, readonly, nullable) NSDate *sunriseTime;
@property (nonatomic, readonly, nullable) NSDate *sunsetTime;
@property (nonatomic, readonly, nullable) NSNumber *precipProbability;
@property (nonatomic, readonly, nullable) NSNumber *precipIntensity;
@property (nonatomic, readonly, nullable, copy) NSString *precipType;
@property (nonatomic, readonly, nullable) NSNumber *temperatureLow;
@property (nonatomic, readonly, nullable) NSNumber *temperatureHigh;
@property (nonatomic, readonly, nullable) NSNumber *apparentTemperature;
@property (nonatomic, readonly, nullable) NSNumber *humidity;
@property (nonatomic, readonly, nullable) NSNumber *pressure;
@property (nonatomic, readonly, nullable) NSNumber *windSpeed;
@property (nonatomic, readonly, nullable) NSNumber *windBearing;
@property (nonatomic, readonly, nullable) NSNumber *uvIndex;








@end

NS_ASSUME_NONNULL_END
