//
//  FGTOpenWeatherModel.m
//  DailyWeather
//
//  Created by FGT MAC on 7/4/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import "FGTOpenWeatherModel.h"
#import "LSIWeatherIcons.h"
#import "LSICardinalDirection.h"


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
    NSArray *weather = [aDictionary objectForKey:@"weather"];
    if(![weather isKindOfClass:NSArray.class])return nil;
    
    NSDictionary *weatherData = [weather objectAtIndex:0];
    
    //TODO: use helper method to show correct format
    NSString *icon = [weatherData objectForKey:@"icon"];
    if(![icon isKindOfClass:NSString.class])return nil;
    
    NSString *desc = [weatherData objectForKey:@"description"];
    if(![desc isKindOfClass:NSString.class])return nil;
    
    //2nd section
    NSDictionary *main = [aDictionary objectForKey:@"main"];
    if(![main isKindOfClass:NSDictionary.class])return nil;
    
    NSNumber *temp = [main objectForKey:@"temp"];
    if(![temp isKindOfClass:NSNumber.class])return nil;
    
    NSNumber *feelsLike = [main objectForKey:@"feels_like"];
    if(![feelsLike isKindOfClass:NSNumber.class])return nil;
    
    NSNumber *humidity = [main objectForKey:@"humidity"];
    if(![humidity isKindOfClass:NSNumber.class])return nil;
    
    NSNumber *pressure = [main objectForKey:@"pressure"];
    if(![pressure isKindOfClass:NSNumber.class])return nil;
    
    NSNumber *tempMin = [main objectForKey:@"temp_min"];
    if(![tempMin isKindOfClass:NSNumber.class])return nil;
    
    NSNumber *tempMax = [main objectForKey:@"temp_max"];
    if(![tempMax isKindOfClass:NSNumber.class])return nil;
    
    //3rd section
    NSDictionary *wind = [aDictionary objectForKey:@"wind"];
    if(![wind isKindOfClass:NSDictionary.class])return nil;
    
    NSNumber *windSpeed = [wind objectForKey:@"speed"];
    if(![windSpeed isKindOfClass:NSNumber.class])return nil;
    
    //TODO: use helper method to show correct format
    NSNumber *degNum = [wind objectForKey:@"deg"];
    if(![degNum isKindOfClass:NSNumber.class])return nil;
    NSString *windDeg = [LSICardinalDirection directionForHeading: degNum.doubleValue];
    
    return [self initWithIcon:  [UIImage imageNamed: @"" ]
                         desc:  desc
                         temp:  temp.doubleValue
                    feelsLike:  feelsLike.doubleValue
                     humidity:  humidity.doubleValue
                     pressure:  pressure.doubleValue
                    windSpeed:  windSpeed.doubleValue
                      windDeg:  windDeg
                      tempMin:  tempMin.doubleValue
                      tempMax:  tempMax.doubleValue];
}


@end
