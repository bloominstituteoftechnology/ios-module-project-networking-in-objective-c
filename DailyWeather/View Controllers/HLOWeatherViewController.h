//
//  HLOWeatherViewController.h
//  DailyWeather
//
//  Created by Karen Rodriguez on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
// MARK:- QQUESTION FOR JON: ^ I had to import CoreLocation in here for the classes to be recognized. Yet in the LSIWeatherViewController.h file there's neither import nor class forwarding yet it is found? What's up with that? :(

typedef void (^LSILocationHandler)(CLPlacemark *placemark, NSError *error);

//NS_ASSUME_NONNULL_BEGIN

@interface HLOWeatherViewController : UIViewController

- (void)requestCurrentPlacemarkForLocation:(CLLocation *)location
                            withCompletion:(void (^)(CLPlacemark *, NSError *))completionHandler;

- (void)requestWeatherForLocation:(CLLocation *)location;
@end

//NS_ASSUME_NONNULL_END
