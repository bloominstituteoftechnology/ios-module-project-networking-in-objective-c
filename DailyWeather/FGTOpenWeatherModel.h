//
//  FGTOpenWeatherModel.h
//  DailyWeather
//
//  Created by FGT MAC on 7/4/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FGTOpenWeatherModel : NSObject

@property (nonatomic, readonly) UIImage *icon;
@property (nonatomic, readonly) NSString *desc;
@property (nonatomic, readonly) double temp;
@property (nonatomic, readonly) double feelsLike;
@property (nonatomic, readonly) double humidity;
@property (nonatomic, readonly) double pressure;
@property (nonatomic, readonly) double windSpeed;
@property (nonatomic, readonly) NSString *windDeg;
@property (nonatomic, readonly) double tempMin;
@property (nonatomic, readonly) double tempMax;

-(instancetype)initWithIcon:(UIImage *)aIcon
                       desc:(NSString *)aDesc
                       temp:(double)aTemp
                  feelsLike:(double)aFeelsLike
                   humidity:(double)aHumidity
                   pressure:(double)aPressure
                  windSpeed:(double)aWindSpeed
                    windDeg:(NSString *)aWindDeg
                    tempMin:(double)aTempMin
                    tempMax:(double)aTempMax NS_DESIGNATED_INITIALIZER;



- (instancetype)initWithDictionary:(NSDictionary *)aDictionary;


@end

NS_ASSUME_NONNULL_END
