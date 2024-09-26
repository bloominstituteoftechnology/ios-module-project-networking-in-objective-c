//
//  LSIDailyForecast.h
//  DailyWeather
//
//  Created by Chris Gonzales on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIDailyForecast : NSObject

@property NSString *icon;
@property NSString *summary;
@property double precipIntensity;
@property double precipProbability;
@property double humidity;
@property double windSpeed;
@property double windBearing;
@property double uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
