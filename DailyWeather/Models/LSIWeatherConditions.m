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
            
            NSString *propertyType = [properties valueForKey:propertyName];
            
            id value = [dictionary objectForKey:codingKey];
            
            // Transform NSNull into nil, applies when JSON key is present but value is NULL
            if ([value isKindOfClass:[NSNull class]]) {
                value = nil;
            }
            
            if (value && [propertyType isEqualToString:@"NSDate"]) {
                // Date Decoding Strategy
                NSNumber *timeNumber = [dictionary objectForKey:codingKey];
                value = [NSDate dateWithTimeIntervalSince1970:timeNumber.doubleValue];
            }

            [self setValue:value forKey:propertyName];
        }
    }
    
    return self;
}

@end
