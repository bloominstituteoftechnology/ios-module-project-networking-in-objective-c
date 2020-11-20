//
//  WeatherVC.h
//  DailyWeather
//
//  Created by Cora Jacobson on 11/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^LSILocationHandler)(CLPlacemark * _Nullable placemark, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface WeatherVC : UIViewController <UITableViewDataSource, UICollectionViewDataSource>

- (void)requestCurrentPlacemarkForLocation:(CLLocation *)location
                            withCompletion:(void (^)(CLPlacemark *, NSError *))completionHandler;


- (void)requestWeatherForLocation:(CLLocation *)location;

@end

NS_ASSUME_NONNULL_END
