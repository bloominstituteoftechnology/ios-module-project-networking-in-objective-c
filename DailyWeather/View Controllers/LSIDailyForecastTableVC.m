//
//  LSIDailyForecastTableVC.m
//  DailyWeather
//
//  Created by David Wright on 5/31/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIDailyForecastTableVC.h"
#import "LSIDailyForecastCell.h"

@class LSIDailyForecast;

@interface LSIDailyForecastTableVC ()

@end

@implementation LSIDailyForecastTableVC

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dailyForecast.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSIDailyForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DayForecastCell" forIndexPath:indexPath];
    
    LSIDailyForecast *dayForecast = [self.dailyForecast objectAtIndex:indexPath.row];
    cell.dayForecast = dayForecast;
    
    return cell;
}

@end
