//
//  DSOWeatherViewController.h
//  DailyWeather
//
//  Created by Sal B Amer on 5/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^LSILocationHandler)(CLPlacemark *placemark, NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface DSOWeatherViewController : UIViewController

- (void)requestCurrentPlacemarkForLocation:(CLLocation *)location
                            withCompletion:(void (^)(CLPlacemark *, NSError *))completionHandler;

- (void)requestWeatherForLocation:(CLLocation *)location;

@end

NS_ASSUME_NONNULL_END
