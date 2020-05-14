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
#import "LSIWeatherForecast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

static NSString *baseURLString = @"https://api.darksky.net/forecast/18990986362b5b52af4a81dd7775c5af/";

@implementation HLOWeatherController

- (instancetype) init {
    self = [super init];
    if (self) {
        _currentForecast = [[LSIWeatherForecast alloc] init];
        _hourlyForecast = [[NSMutableArray<LSIHourlyForecast *> alloc] init];
        _dailyForecast = [[NSMutableArray<LSIDailyForecast *> alloc] init];
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

    // First take care of current weather:
    NSDictionary *currentForecastDic = json[@"currently"];
    _currentForecast = [[LSIWeatherForecast alloc] initWithDictionary:currentForecastDic];
    NSLog(@"Current weather summary %@", self.currentForecast.summary);

    // Take care of daily
    NSDictionary *dailyContainer = json[@"daily"];
    NSArray *dailyArray = dailyContainer[@"data"];
    for (NSDictionary *day in dailyArray) {
        LSIDailyForecast *newDay = [[LSIDailyForecast alloc] initWithDictionary:day];
        [self.dailyForecast addObject:newDay];
    }
    NSLog(@"Days Count: %d first day: %@", self.dailyForecast.count, self.dailyForecast[0].summary);

    if (jsonError) {
        completionBlock(jsonError);
        return;
    }
    // Containers first:

    completionBlock(nil);
}

@end
