//
//  CBDWeatherFetcher.h
//  DailyWeather
//
//  Created by Christopher Devito on 5/14/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBDWeatherForecast;

typedef void (^CBDWeatherFetcherCompletion)(CBDWeatherForecast *_Nullable forcast, NSError *_Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface CBDWeatherFetcher : NSObject

- (void)fetchWeatherAtLatitude:(double)latitude
                     longitude:(double)longitude
               completionBlock:(CBDWeatherFetcherCompletion)completionBlock;

@end

NS_ASSUME_NONNULL_END
