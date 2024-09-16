//
//  LSIWeatherFetcher.h
//  DailyWeather
//
//  Created by Sal B Amer on 5/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSIWeatherForcast;

typedef void(^WeatherFetcherCompletionHandler) (NSArray * _Nullable weather, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherFetcher : NSObject

- (void)fetchWeatherByLocation:(double)latitide
                    longtitude:(double)longtitude
                    completion:(WeatherFetcherCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
