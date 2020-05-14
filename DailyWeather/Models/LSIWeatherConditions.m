//
//  LSIWeatherConditions.m
//  DailyWeather
//
//  Created by Shawn Gee on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherConditions.h"
#import "PropertyUtil.h"

@implementation LSIWeatherConditions

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSDictionary *properties = [PropertyUtil classPropsFor:[self class]];
    NSDictionary *codingKeys = @{@"iconString": @"icon"};
    
    if (self = [super init]) {

        for (NSString *propertyName in [properties keyEnumerator]) {
            NSString *codingKey = codingKeys[propertyName];
            if (!codingKey) {
                codingKey = propertyName;
            }
            
            id value = [dictionary objectForKey:codingKey];
            
            if ([value isKindOfClass:[NSNull class]]) {
                value = nil;
            }
            
            [self setValue:value forKey:propertyName];
        }
        
        NSLog(@"%@", self.summary);
    }
    
    return self;
}

@end
