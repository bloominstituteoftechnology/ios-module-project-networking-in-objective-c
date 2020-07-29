//
//  LSIWeatherForecast.h
//  DailyWeather
//
//  Created by Claudia Maciel on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForecast : NSObject

- (instancetype)initWithCurrently:(NSDictionary *)currently
                            daily:(NSDictionary *)daily
                           hourly:(NSDictionary *)hourly;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSDictionary *currently;
@property (nonatomic, readonly, copy) NSDictionary *daily;
@property (nonatomic, readonly, copy) NSDictionary *hourly;

@end

NS_ASSUME_NONNULL_END
