//
//  LSICurrentForecast.m
//  DailyWeather
//
//  Created by Matthew Martindale on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSICurrentForecast.h"

@implementation LSICurrentForecast

- (instancetype)initWithTime: (NSDate *)time
                     summary: (NSString *)summary
                        icon: (NSString *)icon
           precipProbability: (int)precipProbability
             precipIntensity: (double)precipIntensity
                 temperature: (double)temperature
         apparentTemperature: (double)apparentTemperature
                    humidity: (double)humidity
                    pressure: (double)pressure
                   windSpeed: (double)windSpeed
                 windBearing: (int)windBearing
                     unIndex: (int)unIndex

@end
