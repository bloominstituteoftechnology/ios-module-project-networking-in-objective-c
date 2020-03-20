//
//  LSIHourlyForecast.h
//  DailyWeather
//
//  Created by Michael on 3/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIHourlyForecast : NSObject

@property NSDate *time;
@property NSString *summary;
@property NSString *icon;
@property NSString *precipType;
@property double precipIntensity;
@property double precipProbability;
@property double temperature;
@property double apparentTemperature;
@property double humidity;
@property double pressure;
@property double windSpeed;
@property double windBearing;
@property double uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
