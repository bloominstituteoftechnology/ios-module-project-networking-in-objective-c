//
//  DSOWeatherViewController.m
//  DailyWeather
//
//  Created by Sal B Amer on 5/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "DSOWeatherViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "LSIWeatherIcons.h"
#import "LSILog.h"
#import "LSIErrors.h"
#import "LSIFileHelper.h"
#import "LSICardinalDirection.h"
#import "LSIWeatherForcast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"
#import "DSOWeatherController.h"
#import "DailyWeatherTableViewCell.h"
#import "HourlyWeatherCollectionViewCell.h"


@interface DSOWeatherViewController () <CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource> {
    BOOL _requestedLocation;
}

@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;
@property (nonatomic) DSOWeatherController *weatherController;

//OUTLETS
@property (weak, nonatomic) IBOutlet UILabel *locationLbl;
@property (weak, nonatomic) IBOutlet UILabel *summaryLbl;
@property (weak, nonatomic) IBOutlet UILabel *tempLbl;

@property (weak, nonatomic) IBOutlet UILabel *currentDayLbl;
@property (weak, nonatomic) IBOutlet UILabel *currentDayTempHighLbl;
@property (weak, nonatomic) IBOutlet UILabel *currentDayTempLowLbl;

@property (weak, nonatomic) IBOutlet UITableView *dailyWeatherTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *hourlyTempCollectionView;

// Refresh Button - Action
- (IBAction)refreshButton:(UIButton *)sender;

@end

@implementation DSOWeatherViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.locationManager requestWhenInUseAuthorization];
  [self.locationManager startUpdatingLocation];
  self.locationManager.delegate = self;
  [self initializeController];
  self.hourlyTempCollectionView.delegate = self;
  self.hourlyTempCollectionView.dataSource = self;
  self.dailyWeatherTableView.delegate = self;
  self.dailyWeatherTableView.dataSource = self;
  [self updateViews];

}

- (void)requestCurrentPlacemarkForLocation:(CLLocation *)location
                            withCompletion:(void (^)(CLPlacemark *, NSError *))completionHandler {
    if (location) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];

        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error) {
                completionHandler(nil, error);
                return;
            }

            if (placemarks.count >= 1) {
                CLPlacemark *place = placemarks.firstObject;

                completionHandler(place, nil);
                [self updateViews];
                return;

            } else {
                NSError *placeError = errorWithMessage(@"No places match current location", LSIPlaceError);

                completionHandler(nil, placeError);
                return;
            }
        }];

    } else {
        NSLog(@"ERROR: Missing location, please provide location");
    }
}

- (void)requestUserFriendlyLocation:(CLLocation *)location {
    if(!_requestedLocation) {
        _requestedLocation = YES;
        __block BOOL requestedLocation = _requestedLocation;

        [self requestCurrentPlacemarkForLocation:location withCompletion:^(CLPlacemark *place, NSError *error) {

            NSLog(@"Location: %@, %@", place.locality, place.administrativeArea);

            dispatch_async(dispatch_get_main_queue(), ^{
                self.location = location;
                self.placemark = place;
                [self updateViews];
            });
            requestedLocation = NO;
        }];
    }
    [self updateViews];
}

- (void)setForecast:(LSIHourlyForecast *)forecast {
    _forecast = forecast;
    [self updateViews];
}

- (void)requestWeatherForLocation:(CLLocation *)location {

}

- (void)updateViews {
    if (self.placemark) {
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.dailyWeatherTableView reloadData];
            [self.hourlyTempCollectionView reloadData];

            self.locationLbl.text = self.placemark.country;
            self.summaryLbl.text = self.weatherController.currentForecast.summary;
////            self.currentDayTempHighLbl.text = [NSString stringWithFormat:@"%.f", self.forecast.temperatureHigh.doubleValue];
//            self.currentDayTempHighLbl.text = self.forecast.temperatureHigh.stringValue;
//            self.currentDayTempLowLbl.text = [NSString stringWithFormat:@"%.f", self.forecast.temperatureLow.doubleValue];
            self.tempLbl.text = [NSString stringWithFormat:@"%d°F", self.weatherController.currentForecast.temperature.intValue];
            NSDate *date = [[NSDate alloc] init];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEEE"]; //E Day of the Week

            self.currentDayLbl.text = [dateFormatter stringFromDate:date];
        });
    }
  
  
  
  [self.weatherController fetchWeatherByLocation:self.location.coordinate.latitude longitude:self.location.coordinate.longitude completionBloc:^(NSError * _Nullable error) {
    if (error) {
      NSLog(@"Error fetching dark sky APi: %@", error);
    }
  }];

    // TODO: Update the UI based on the current forecast
}


- (void)initializeController {
    if (!_weatherController) {
        _weatherController = [[DSOWeatherController alloc] init];
      [self.weatherController parseJSONData:loadFile(@"Weather.json", [LSIWeatherForcast class]) completionBloc:^(NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateViews];
            });
        }];
    }
}


// MARK:- CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"locationManager Error: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"locationManager: found location %@", locations.firstObject);

    CLLocation *location = locations.firstObject;

    // 1. Request Weather for location

    [self requestWeatherForLocation: location];

    // 2. Request User-Friendly Place Names for Lat/Lon coordinate

    [self requestUserFriendlyLocation: location];

    // Stop updating location after getting one (NOTE: this is faster than doing a single location request)
    [manager stopUpdatingLocation];
}

// MARK:- TableView Protocols

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DailyWeatherTableViewCell *cell = (DailyWeatherTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];

    cell.forecast = self.weatherController.dailyForecast[indexPath.row];

    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.weatherController.dailyForecast) {
        return self.weatherController.dailyForecast.count;
    }
    return 0;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HourlyWeatherCollectionViewCell *cell = (HourlyWeatherCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];

    if (indexPath.row == 0) {
        cell.isNow = true;
        cell.forecast = self.weatherController.hourlyForecast[indexPath.row];
    } else {
        cell.isNow = false;
        cell.forecast = self.weatherController.hourlyForecast[indexPath.row];
    }

    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.weatherController.hourlyForecast) {
        return self.weatherController.hourlyForecast.count;
    }
    return 0;
}


- (IBAction)refreshButton:(UIButton *)sender {
  
  [self.weatherController fetchWeatherByLocation:self.location.coordinate.latitude longitude:self.location.coordinate.longitude completionBloc:^(NSError * _Nullable error) {
    if (error) {
      NSLog(@"Error fetching dark sky APi: %@", error);
    }
  }];
  
}
@end
