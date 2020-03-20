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

- (void)getJson:(completionHandler)completion {
    NSURL *url = [NSURL URLWithString:@"https://api.darksky.net/forecast/c2b09f477e038a95921374ff08b910f7/37.8267,-122.4233"];
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) { completion(nil, response, error); }
        if (!data) { completion(nil, response, error); }
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        AMSWeather *forecast = [[AMSWeather alloc] initWithDictionary:json];
        self->_weather = forecast;
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(forecast, response, nil);
        });
    }];
    [task resume];
}

@end
