//
//  HourlyCollectionViewCell.m
//  DailyWeather
//
//  Created by Karen Rodriguez on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "HourlyCollectionViewCell.h"
#import "LSIHourlyForecast.h"
#import "LSIWeatherIcons.h"

@interface HourlyCollectionViewCell ()

// MARK:- Outlets
@property (strong, nonatomic) IBOutlet UILabel *hourLabel;
@property (strong, nonatomic) IBOutlet UIImageView *iconLabel;
@property (strong, nonatomic) IBOutlet UILabel *highTempLabel;

@end

@implementation HourlyCollectionViewCell

- (void)updateViews {

    if (self.isNow) {
        self.hourLabel.text = @"Now";
    } else {
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(int)self.forecast.time];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh a"];

        self.hourLabel.text = [dateFormatter stringFromDate:self.forecast.time];
    }
    self.iconLabel.image = [LSIWeatherIcons weatherImageForIconName:self.forecast.icon];
    self.highTempLabel.text = self.forecast.temperatureHigh.stringValue;

}

- (void)setForecast:(LSIHourlyForecast *)forecast {
    // Setter
    _forecast = forecast;

    // didSet
    [self updateViews];
}
@end
