//
//  CMDWeatherForecast.h
//  DailyWeather
//
//  Created by Chris Dobek on 6/11/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CMDCurrentForecast;
@class CMDHourlyForecast;
@class CMDDailyForecast;

NS_ASSUME_NONNULL_BEGIN

@interface CMDWeatherForecast : NSObject

@property (nonatomic) CMDCurrentForecast *currentForecast;
@property (nonatomic) NSArray<CMDHourlyForecast *> *hourlyForecasts;
@property (nonatomic) NSArray<CMDDailyForecast *> *dailyForecasts;

- (instancetype)initWithCurrentForecast:(CMDCurrentForecast *)currentForecast
                        hourlyForecasts:(NSArray *)hourlyForecasts
                         dailyForecasts:(NSArray *)dailyForecasts;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
