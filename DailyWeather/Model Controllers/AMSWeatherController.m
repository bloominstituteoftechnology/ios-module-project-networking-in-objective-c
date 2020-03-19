//
//  AMSWeatherController.m
//  DailyWeather
//
//  Created by Alexander Supe on 19.03.20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "AMSWeatherController.h"
#import "LSIFileHelper.h"

@implementation AMSWeatherController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSData *data = loadFile(@"Weather.json", AMSWeatherController.class);
        NSError *error = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        AMSWeather *forecast = [[AMSWeather alloc] initWithDictionary:json];
        _weather = forecast;
    }
    return self;
}

@end
