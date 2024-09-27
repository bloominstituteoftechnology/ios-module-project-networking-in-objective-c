//
//  LSISettingsTableVC.m
//
//  Created by Paul Solt on 2/18/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSISettingsTableVC.h"
#import "LSIWeatherForecast.h"
#import "WeatherVC.h"

@interface LSISettingsTableVC ()

@end

@implementation LSISettingsTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Today's Weather v.1.0";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"Powered by Dark Sky";
        cell.textLabel.textColor = UIColor.systemBlueColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        NSURL *url =  [NSURL URLWithString:@"https://darksky.net/poweredby/"];
        [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
    } else if (indexPath.row == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        WeatherVC *weatherVC = [storyboard instantiateViewControllerWithIdentifier:@"WeatherVC"];
        [self presentViewController:weatherVC animated:YES completion:nil];
    }
}

@end
