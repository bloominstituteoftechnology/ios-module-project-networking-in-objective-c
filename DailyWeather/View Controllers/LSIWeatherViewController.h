//
//  LSIWeatherViewController.h
//
//  Created by Paul Solt on 2/6/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LSILocationHandler)(CLPlacemark *placemark, NSError *error);

@interface LSIWeatherViewController : UIViewController


//- (void)requestCurrentLocationWithCompletion:(LSILocationHandler)completionHandler;
- (void)requestCurrentPlacemarkForLocation:(CLLocation *)location
                            withCompletion:(void (^)(CLPlacemark *, NSError *))completionHandler;


- (void)requestWeatherForLocation:(CLLocation *)location;

@end

