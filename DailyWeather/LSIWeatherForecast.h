//
//  LSIWeatherForecast.h
//  DailyWeather
//
//  Created by Karen Rodriguez on 5/12/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForecast : NSObject

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly, copy) NSString *summary; // optional
@property (nonatomic, readonly, copy) NSString *icon; // optional
@property (nonatomic, readonly) NSNumber *precipProbability; // optional
@property (nonatomic, readonly) NSNumber *precipIntensity; // optional
@property (nonatomic, readonly) NSNumber *temperature; // optional
@property (nonatomic, readonly) NSNumber *apparentTemperature; // optional
@property (nonatomic, readonly) NSNumber *humidity; // optional
@property (nonatomic, readonly) NSNumber *pressure; // optional
@property (nonatomic, readonly) NSNumber *windSpeed; // optional
@property (nonatomic, readonly) NSNumber *windBearing; // optional
@property (nonatomic, readonly) NSNumber *uvIndex; // optional

@end

NS_ASSUME_NONNULL_END
