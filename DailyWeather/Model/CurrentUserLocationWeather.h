//
//  CurrentUserLocationWeather.h
//  DailyWeather
//
//  Created by Nick Nguyen on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CurrentUserLocationWeather : NSObject

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly) NSString *summary;
@property (nonatomic, readonly) NSString *icon;
@property (nonatomic, readonly) double temperature;
@property (nonatomic, readonly) double humidity;
@property (nonatomic, readonly) double pressure;
@property (nonatomic, readonly) double windSpeed;
@property (nonatomic, readonly) int uvIndex;
@property (nonatomic, readonly) int visibility;

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
                 temperature:(double )temperature
                    humidity:(double )humidity
                    pressure:(double )pressure
                   windSpeed:(double )windSpeed
                     uvIndex:(int )uvIndex
                  visibility:(int )visibility;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end


NS_ASSUME_NONNULL_END
