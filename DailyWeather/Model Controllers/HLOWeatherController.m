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
- (void)fetchForecastWithLatitude:(double)latitude
                        longitude:(double)longitude
                   completionBloc:(void (^)(NSError * _Nullable error))completionBlock {

    // Initialize URL Components
//    NSURLComponents *urlComponents = [[NSURLComponents alloc] init];

    // Create compoinents
//    urlComponents.queryItems = @[
//        [NSURLQueryItem queryItemWithName:<#(nonnull NSString *)#> value:<#(nullable NSString *)#>]
//    ];

    // Time for some freestyle, as it seems this doesn't use queries but url extensions
    NSURL *baseURL = [[NSURL alloc] initWithString:baseURLString]; // Nice. I get bracket syntax now.
    NSString *locationCoordinates = [NSString stringWithFormat:@"%f,%f", latitude, longitude];
    NSURL *requestURL = [baseURL URLByAppendingPathComponent:locationCoordinates];

    // Test before we waste any API calls
    NSLog(@"%@", requestURL.absoluteString);

    // Create datatask
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Inside of datatask commpletionHandler with url: %@", requestURL);

        if (error) {
            completionBlock(error);
            return;
        }

        if (!data) {
            NSError *dataError = errorWithMessage(@"No data in URL response for weather forecast", LSIDataNilError);
            completionBlock(dataError);
            return;
        }

        // Let's hope I did this part rightlol
        [self parseJSONData:data completionBloc:^(NSError * _Nullable error){
            completionBlock(error);
            return;
        }];
    }];

    [task resume];

}

- (void)parseJSONData:(NSData *)data
       completionBloc:(void (^)(NSError * _Nullable error))completionBlock {

    NSError *jsonError = nil;

    // Create dictionary from data
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

    NSLog(@"json parsed: %@", json);

    if (jsonError) {
        completionBlock(jsonError);
        return;
    }
    // Containers first:

    completionBlock(nil);
}

@end
