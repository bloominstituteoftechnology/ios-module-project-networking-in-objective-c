//
//  PropertyUtil.h
//  DailyWeather
//
//  Created by Shawn Gee on 5/14/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PropertyUtil : NSObject

+ (NSDictionary *)classPropsFor:(Class)klass;

@end

NS_ASSUME_NONNULL_END
