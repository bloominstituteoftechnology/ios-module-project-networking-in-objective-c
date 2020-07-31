//
//  LSIWeatherForecast.h
//  DailyWeather
//
//  Created by Chad Parker on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSICurrentForecast;

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForecast : NSObject

@property (nonatomic) LSICurrentForecast *currentForecast;

@end

NS_ASSUME_NONNULL_END
