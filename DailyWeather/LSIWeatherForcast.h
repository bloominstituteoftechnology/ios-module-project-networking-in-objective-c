//
//  LSIWeatherForcast.h
//  DailyWeather
//
//  Created by Jessie Ann Griffin on 5/26/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIWeatherForcast : NSObject

- (instancetype)initWithCurrently:(NSDictionary *)currently
                            daily:(NSDictionary *)daily
                           hourly:(NSDictionary *)hourly;

//- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSDictionary *currently;
@property (nonatomic, readonly, copy) NSDictionary *daily;
@property (nonatomic, readonly, copy) NSDictionary *hourly;

//@property (nonatomic, readonly) NSDate *time;
//@property (nonatomic, readonly, copy) NSString *summary;
//@property (nonatomic, readonly, copy) NSString *icon;
//@property (nonatomic, readonly) int precipProbability;
//@property (nonatomic, readonly) int precipIntensity;
//@property (nonatomic, readonly) double temperature;
//@property (nonatomic, readonly) double humidity;
//@property (nonatomic, readonly) double pressure;
//@property (nonatomic, readonly) double windSpeed;
//@property (nonatomic, readonly, copy) NSString *windBearing;
//@property (nonatomic, readonly) int uvIndex;

@end

NS_ASSUME_NONNULL_END
