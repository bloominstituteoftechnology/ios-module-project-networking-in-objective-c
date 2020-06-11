//
//  LSIDailyForcast.h
//  DailyWeather
//
//  Created by Bhawnish Kumar on 6/10/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIDailyForcast : NSObject

@property (nonatomic) NSDate *time;
@property (nonatomic, nullable, readonly, copy) NSString *summary;
@property(nonatomic, nullable, readonly, copy)  NSString *icon;
@property (nonatomic, nullable, readonly) NSDate *sunriseTime;
@property (nonatomic, nullable, readonly) NSDate *sunsetTime;
@property (nonatomic, nullable, readonly) NSNumber *precipProbability;
@property (nonatomic, nullable, readonly) NSNumber *precipIntensity;
@property (nonatomic, nullable, readonly, copy) NSString *precipType;
@property (nonatomic, nullable, readonly) NSNumber *temperatureLow;
@property (nonatomic, nullable, readonly) NSNumber *temperatureHigh;
@property (nonatomic, nullable, readonly) NSNumber *apparentTemperature;
@property (nonatomic, nullable, readonly) NSNumber *humidity;
@property (nonatomic, nullable, readonly) NSNumber *pressure;
@property (nonatomic, nullable, readonly) NSNumber *windSpeed;
@property (nonatomic, nullable, readonly) NSNumber *windBearing;
@property (nonatomic, nullable, readonly) NSNumber *uvIndex;

@end

NS_ASSUME_NONNULL_END
