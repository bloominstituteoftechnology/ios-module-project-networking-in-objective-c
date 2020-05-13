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

@property NSDate *time;
@property NSString *summary; // optional
@property NSString *icon; // optional
@property NSNumber *precipProbability; // optional
@property NSNumber *precipIntensity; // optional
@property NSNumber *temperature; // optional
@property NSNumber *apparentTemperature; // optional
@property NSNumber *humidity; // optional
@property NSNumber *pressure; // optional
@property NSNumber *windSpeed; // optional
@property NSNumber *windBearing; // optional
@property NSNumber *uvIndex; // optional

@end

NS_ASSUME_NONNULL_END
