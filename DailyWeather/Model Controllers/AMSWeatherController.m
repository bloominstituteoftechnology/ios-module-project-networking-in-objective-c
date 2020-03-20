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


- (void)getJson:(completionHandler)completion
       location:(CLLocationCoordinate2D)location {
    NSURL *url = [NSURL URLWithString:@"/"];
    NSURL *finalURL = [url URLByAppendingPathComponent:[NSString stringWithFormat:@"%.4f,%.4f",location.latitude, location.longitude]];
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
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
