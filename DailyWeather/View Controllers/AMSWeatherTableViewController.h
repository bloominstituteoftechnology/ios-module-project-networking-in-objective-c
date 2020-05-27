//
//  AMSWeatherTableViewController.h
//  DailyWeather
//
//  Created by Alexander Supe on 20.03.20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMSWeather.h"

NS_ASSUME_NONNULL_BEGIN

@interface AMSWeatherTableViewController : UITableViewController

@property (readonly, nonatomic) AMSWeather *weather;
@property (readonly, nonatomic) BOOL isDaily;

- (void)setWeather:(AMSWeather * _Nonnull)weather;
- (void)setIsDaily:(BOOL)isDaily;

@end

NS_ASSUME_NONNULL_END
