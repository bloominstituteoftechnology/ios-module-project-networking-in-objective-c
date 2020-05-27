//
//  AMSWeatherTableViewController.m
//  DailyWeather
//
//  Created by Alexander Supe on 20.03.20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "AMSWeatherTableViewController.h"
#import "AMSWeatherTableViewCell.h"
#import "AMSForcast.h"
#import "LSIWeatherIcons.h"

@interface AMSWeatherTableViewController ()

@end

@implementation AMSWeatherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self tableView] setBackgroundColor:UIColor.clearColor];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _isDaily ? self.weather.daily.count : self.weather.hourly.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMSWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //    [cell.textLabel setText:_isDaily ? [_weather.daily[indexPath.row]summary] : [_weather.hourly[indexPath.row]summary]];
    NSObject<AMSForcast> *thisWeather = _isDaily ? _weather.daily[indexPath.row] : _weather.hourly[indexPath.row];
    
    [cell setBackgroundColor:UIColor.clearColor];
    
    [cell.lowTempLabel setFont:[UIFont monospacedDigitSystemFontOfSize:17 weight:UIFontWeightRegular]];
    NSString *lowTemp = [NSString stringWithFormat:@"%d°", thisWeather.temperatureLow.intValue];
    if (_isDaily) {
        [cell.lowTempLabel setText: lowTemp];
    } else {
        [cell.lowTempLabel setText: @" "];
    }
    [cell.highTempLabel setFont:[UIFont monospacedDigitSystemFontOfSize:17 weight:UIFontWeightRegular]];
    NSString *highTemp = [NSString stringWithFormat:@"%d°", thisWeather.temperatureHigh.intValue];
    [cell.highTempLabel setText: highTemp];
    
    NSString *condition = thisWeather.icon;
    [cell.conditionImageView setImage:[LSIWeatherIcons weatherImageForIconName:condition]];
    
    NSString *time = _isDaily ? [self getDate:thisWeather.time] : [self getTime:thisWeather.time];
    [cell.timeLabel setText: time];
    return cell;
}

- (NSString *)getTime:(NSDate *)date {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeStyle = NSDateFormatterShortStyle;
    return [formatter stringFromDate:date];
}

- (NSString *)getDate:(NSDate *)date {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"EEEE"];
    return [formatter stringFromDate:date];
}

- (void)setWeather:(AMSWeather * _Nonnull)weather {
    _weather = weather;
    [self.tableView reloadData];
}

- (void)setIsDaily:(BOOL)isDaily {
    _isDaily = isDaily;
    [self.tableView reloadData];
}

@end
