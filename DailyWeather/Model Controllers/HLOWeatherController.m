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

    // Initialize URL Components
//    NSURLComponents *urlComponents = [[NSURLComponents alloc] init];

    // Create compoinents
//    urlComponents.queryItems = @[
//        [NSURLQueryItem queryItemWithName:<#(nonnull NSString *)#> value:<#(nullable NSString *)#>]
//    ];

    // Time for some freestyle, as it seems this doesn't use queries but url extensions
    NSURL *baseURL = [[NSURL alloc] initWithString:baseURLString]; // Nice. I get bracket syntax now.
    NSString *locationCoordinates = [NSString stringWithFormat:@"%f,%f", latitude.doubleValue, longitude.doubleValue];
    NSURL *requestURL = [baseURL URLByAppendingPathComponent:locationCoordinates];

    // Test before we waste any API calls
    NSLog(@"");

}

- (void)parseJSONData:(NSData *)data {

}

@end
