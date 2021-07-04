//
//  FGTOpenWeatherModel.m
//  DailyWeather
//
//  Created by FGT MAC on 7/4/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import "FGTOpenWeatherModel.h"

@implementation FGTOpenWeatherModel

-(instancetype)init
{
    return [self initWithIcon:[UIImage imageNamed:@""]
                         desc:@""
                         temp:0
                    feelsLike:0
                     humidity:0
                     pressure:0
                    windSpeed:0
                      windDeg:@""
                      tempMin:0
                      tempMax:0];
}

-(instancetype)initWithIcon:(UIImage *)aIcon
                       desc:(NSString *)aDesc
                       temp:(double)aTemp
                  feelsLike:(double)aFeelsLike
                   humidity:(double)aHumidity
                   pressure:(double)aPressure
                  windSpeed:(double)aWindSpeed
                    windDeg:(NSString *)aWindDeg
                    tempMin:(double)aTempMin
                    tempMax:(double)aTempMax
{
    self = [super init];
    if(self){
        _icon = aIcon;
        _desc = aDesc;
        _feelsLike = aFeelsLike;
        _temp = aTemp;
        _humidity = aHumidity;
        _pressure = aPressure;
        _windSpeed = aWindSpeed;
        _windDeg = aWindDeg;
        _tempMin = aTempMin;
        _tempMax = aTempMax;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    //Get data from OpenWeather api
    
    
    
    
    
    
    return [self initWithIcon:[UIImage imageNamed:@""]
                         desc:@""
                         temp:0
                    feelsLike:0
                     humidity:0
                     pressure:0
                    windSpeed:0
                      windDeg:@""
                      tempMin:0
                      tempMax:0];
}


@end
