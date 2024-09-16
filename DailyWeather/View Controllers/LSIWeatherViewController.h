//
//  LSIWeatherViewController.h
//
//  Created by Paul Solt on 2/6/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSIWeatherForecast;


typedef void (^LSILocationHandler)(CLPlacemark *placemark, NSError *error);
typedef void (^LSIWeatherFetcherCompletion)(NSArray<LSIWeatherForecast *> * forecast, NSError * error);

@class LSIWeatherIcons;

@interface LSIWeatherViewController : UIViewController

@property LSIWeatherIcons *weatherIconsController;
//- (void)requestCurrentLocationWithCompletion:(LSILocationHandler)completionHandler;
- (void)requestCurrentPlacemarkForLocation:(CLLocation *)location
                            withCompletion:(void (^)(CLPlacemark *, NSError *))completionHandler;


- (void)requestWeatherForLocation:(CLLocation *)location;




@end

