//
//  LSIWeatherFetcher.h
//  DailyWeather
//
//  Created by Claudia Maciel on 7/30/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class LSICurrentForecast;

typedef void (^LSICurrentLocationFetcherCompletionBlock)(NSArray<LSICurrentForecast *> *_Nullable weathers, NSError * _Nullable error);

@interface LSIWeatherFetcher : NSObject

- (void)fetchCurrentWeatherUsingLatitude:(double)latitude longtitude:(double)longitude completionBlock:(LSICurrentLocationFetcherCompletionBlock)completionBlock;


@end

NS_ASSUME_NONNULL_END
