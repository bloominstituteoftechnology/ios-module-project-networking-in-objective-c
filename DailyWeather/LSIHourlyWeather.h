//
//  LSIHourlyWeather.h
//  DailyWeather
//
//  Created by Bhawnish Kumar on 6/10/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIHourlyWeather : NSObject

@property (nonatomic) NSDate *time;
@property (nonatomic, nullable, readonly, copy) NSString *summary;
@property(nonatomic, nullable, readonly, copy)  NSString *icon;
@property (nonatomic, nullable, readonly) NSNumber *precipProbability;
@property (nonatomic, nullable, readonly, copy) NSString *precipType;
@property (nonatomic, nullable, readonly) NSNumber *temperature;
@property (nonatomic, nullable, readonly) NSNumber *apparentTemperature;
@property (nonatomic, nullable, readonly) NSNumber *humidity;
@property (nonatomic, nullable, readonly) NSNumber *pressure;
@property (nonatomic, nullable, readonly) NSNumber *windSpeed;
@property (nonatomic, nullable, readonly) NSNumber *windBearing;
@property (nonatomic, nullable, readonly) NSNumber *uvIndex;

- (instancetype)initWithTime:(NSDate *)time
                     summary:(NSString *)summary
                        icon:(NSString *)icon
           precipProbability:(NSNumber *)precipProbability
                  precipType:(NSString *)precipType
              temperature:(NSNumber *)temperature
         apparentTemperature:(NSNumber *)apparentTemperature
                    humidity:(NSNumber *)humidity
                    pressure:(NSNumber *)pressure
                   windSpeed:(NSNumber *)windSpeed
                 windBearing:(NSNumber *)windBearing
                     uvIndex:(NSNumber *)uvIndex;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
