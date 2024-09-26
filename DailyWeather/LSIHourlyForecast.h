//
//  LSIHourlyForecast.h
//  DailyWeather
//
//  Created by Chris Gonzales on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIHourlyForecast : NSObject

@property NSDate *date;
@property NSString *summary;
@property NSString *icon;
@property double temperature;
@property double precipIntensity;
@property double precipProbability;
@property NSString *precipType;
@property double humidity;
@property double windSpeed;
@property double windBearing;
@property double uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
