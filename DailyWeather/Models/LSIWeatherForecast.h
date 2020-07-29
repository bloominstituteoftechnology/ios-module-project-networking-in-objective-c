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


- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(int)precipProbability
             precipIntensity:(int)precipIntensity
                 temperature:(double)temperature
                    humidity:(double)humity
                    pressure:(double)pressure
                   windSpeed:(double)windSpeed
                 windBearing:(NSString *)windBearing
                     uvIndex:(NSInteger *)uvIndex;


- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly, copy) NSString *summary;
@property (nonatomic, readonly, copy) NSString *icon;
@property (nonatomic, readonly) int precipProbability;
@property (nonatomic, readonly) int precipIntensity;
@property (nonatomic, readonly) double temperature;
@property (nonatomic, readonly) double humidity;
@property (nonatomic, readonly) double pressure;
@property (nonatomic, readonly) double windSpeed;
@property (nonatomic, readonly, copy) NSString *windBearing;
@property (nonatomic, readonly) NSInteger *uvIndex;


@end

NS_ASSUME_NONNULL_END
