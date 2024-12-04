//
//  WeatherFetcher.h
//  DailyWeather
//
//  Created by Sean Acres on 7/30/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSIWeatherResults.h"

typedef void(^WeatherFetcherCompletionHandler)(LSIWeatherResults *_Nullable results, NSError *_Nullable error);

@interface WeatherFetcher : NSObject

- (void)fetchWeatherWithCompletionHandler:(nonnull WeatherFetcherCompletionHandler)completionHandler;

- (void)fetchWeatherWithLatitude:(double)latitude
                       longitude:(double)longitude
               completionHandler:(nonnull WeatherFetcherCompletionHandler)completionHandler;

@end

