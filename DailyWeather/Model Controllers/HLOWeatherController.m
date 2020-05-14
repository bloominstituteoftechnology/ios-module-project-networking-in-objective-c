//
//  WeatherController.m
//  DailyWeather
//
//  Created by Karen Rodriguez on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "HLOWeatherController.h"
#import "LSIErrors.h"
#import "LSILog.h"

static NSString *baseURLString = @"https://api.darksky.net/forecast/18990986362b5b52af4a81dd7775c5af/";

@implementation HLOWeatherController

- (instancetype) init {
    self = [super init];
    if (self) {
        _currentForecast = nil;
        _hourlyForecast = nil;
        _dailyForecast = nil;
    }
    return self;
}
- (void)fetchForecastWithLatitude:(NSNumber *)latitude
                        longitude:(NSNumber *)longitude {

}

- (void)parseJSONData:(NSData *)data {

}

@end
