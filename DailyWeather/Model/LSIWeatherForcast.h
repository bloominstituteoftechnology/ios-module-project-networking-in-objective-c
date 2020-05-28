//
//  LSIWeatherForcast.h
//  DailyWeather
//
//  Created by David Wright on 5/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSICurrentForecast;

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForcast : NSObject

- (instancetype)initWithCurrentForecast:(LSICurrentForecast *)currentForecast NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly, copy) LSICurrentForecast *currentForecast;

@end

NS_ASSUME_NONNULL_END
