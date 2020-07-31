//
//  WeatherNetwork.h
//  DailyWeather
//
//  Created by Matthew Martindale on 7/30/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSIWeatherForcast.h"

typedef void(^WeatherFetchCompletionHandler)(LSIWeatherForcast *_Nullable weatherForecast, NSError *_Nullable error);

@interface WeatherNetwork : NSObject

- (void)fetchWeatherForecast:(nonnull WeatherFetchCompletionHandler)completionHandler;

@end

