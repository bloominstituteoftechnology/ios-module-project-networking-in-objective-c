//
//  LSIWeatherForecast.h
//  DailyWeather
//
//  Created by Kelson Hartle on 7/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSICurrentForecast;

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForecast : NSObject

@property LSICurrentForecast *current;




@end

NS_ASSUME_NONNULL_END
