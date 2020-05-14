//
//  CBDWeatherFetcher.m
//  DailyWeather
//
//  Created by Christopher Devito on 5/14/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "CBDWeatherFetcher.h"
#import "LSIErrors.h"
#import "CBDWeatherForecast.h"

@implementation CBDWeatherFetcher

static NSString *baseURLString = @"https://api.darksky.net/forecast/18990986362b5b52af4a81dd7775c5af";
// https://api.darksky.net/forecast/[key]/[latitude],[longitude]

- (void)fetchWeatherAtLatitude:(double)latitude
                     longitude:(double)longitude
               completionBlock:(CBDWeatherFetcherCompletion)completionBlock {

    NSLog(@"Fetching...");

    
    NSString *locationCoordinates = [NSString stringWithFormat:@"%f,%f", latitude, longitude];
    NSURL *baseURL = [[NSURL alloc] initWithString:baseURLString];
    NSURL *requestURL = [baseURL URLByAppendingPathComponent:locationCoordinates];
    
    if (!requestURL) {
        return;
    }
    
    NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            completionBlock(nil, error);
            return;
        }
        
        if (!data) {
            NSError *dataError = errorWithMessage(@"No weather data returned", LSIDataNilError);
            completionBlock(nil, dataError);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) {
            completionBlock(nil, jsonError);
            return;
        }
        
        CBDWeatherForecast *weatherForecast = [[CBDWeatherForecast alloc] initWithDictionary:dictionary];
        completionBlock(weatherForecast, nil);
        
    }];
    [task resume];

    
}
@end
