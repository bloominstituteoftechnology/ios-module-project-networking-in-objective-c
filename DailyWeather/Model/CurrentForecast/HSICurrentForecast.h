//
//  HSICurrentForecast.h
//  DailyWeather
//
//  Created by Kenny on 6/10/20.
//  Copyright © 2020 Hazy Studios Incorporated. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSICurrentForecast : NSObject

//r=required o=optional //d=dependent on above property
@property (nonatomic) NSDate *time; //r

@property (nonatomic, copy) NSString *summary; //o

@property (nonatomic, copy) NSString *icon; //o

@property (nonatomic) double precipProbability; //o
@property (nonatomic) double precipIntensity; //o d

@property (nonatomic) double temperature; //o
@property (nonatomic) double apparentTemperature; //o d

@property (nonatomic) double humidity; //o

@property (nonatomic) double pressure; //o

@property (nonatomic) double windSpeed; //o
@property (nonatomic) int windBearing; //o d

- (instancetype) initWithTime:(NSDate *)time summary:(NSString *)summary icon:(NSString *)icon precipProbability:(double)precipProbability precipIntensity:(double)precipIntensity temperature:(double)temperature apparentTemperature:(double)apparentTemperature humidity:(double)humidity pressure:(double)pressure windSpeed:(double)windSpeed windBearing:(int)windBearing;

- (instancetype) initWithDictionary:(NSDictionary *) dictionary;

@end

NS_ASSUME_NONNULL_END
