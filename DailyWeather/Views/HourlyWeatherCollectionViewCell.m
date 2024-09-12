//
//  HourlyWeatherCollectionViewCell.m
//  DailyWeather
//
//  Created by Sal B Amer on 5/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "HourlyWeatherCollectionViewCell.h"
#import "LSIHourlyForecast.h"
#import "LSIWeatherIcons.h"

@interface HourlyWeatherCollectionViewCell ()

//OUTLETS TO COLLECTION VIEW CELLS

@property (weak, nonatomic) IBOutlet UILabel *hourLbl;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIconImg;
@property (weak, nonatomic) IBOutlet UILabel *highTempLbl;

@end

@implementation HourlyWeatherCollectionViewCell

- (void)updateViews {

    if (self.isNow) {
        self.hourLbl.text = @"NOW";
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh a"];
        self.hourLbl.text = [dateFormatter stringFromDate:self.forecast.time];
    }
    self.weatherIconImg.image = [LSIWeatherIcons weatherImageForIconName:self.forecast.icon];
//    self.highTempLbl.text = self.forecast.temperatureHigh.stringValue; // Displaying too many zeros
  self.highTempLbl.text = [NSString stringWithFormat:@"%.f°F", _forecast.apparentTemperature.doubleValue];
  
}

- (void)setForecast:(LSIHourlyForecast *)forecast {
    _forecast = forecast;
    [self updateViews];
}

@end
