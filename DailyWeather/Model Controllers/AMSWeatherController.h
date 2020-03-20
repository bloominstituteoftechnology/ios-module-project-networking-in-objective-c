//
//  AMSWeatherController.h
//  DailyWeather
//
//  Created by Alexander Supe on 19.03.20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMSWeather.h"

NS_ASSUME_NONNULL_BEGIN

@interface AMSWeatherController : NSObject

@property (nonatomic, readonly) AMSWeather *weather;

typedef void(^completionHandler)(AMSWeather * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);

- (void)getJson:(completionHandler)completion;

@end

NS_ASSUME_NONNULL_END
