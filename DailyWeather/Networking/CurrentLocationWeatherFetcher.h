//
//  CurrentLocationWeatherFetcher.h
//  DailyWeather
//
//  Created by Nick Nguyen on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class LSICurrentWeather;

typedef void (^LSICurrentLocationFetcherCompletionBlock)(NSArray<LSICurrentWeather *> *_Nullable weathers, NSError * _Nullable error);

@interface CurrentLocationWeatherFetcher : NSObject

- (void)fetchCurrentWeatherUsingLatitude:(double)latitude longtitude:(double)longitude completionBlock:(LSICurrentLocationFetcherCompletionBlock)completionBlock;




@end

NS_ASSUME_NONNULL_END
