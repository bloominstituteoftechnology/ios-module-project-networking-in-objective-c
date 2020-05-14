//
//  HLOWeatherViewController.m
//  DailyWeather
//
//  Created by Karen Rodriguez on 5/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "HLOWeatherViewController.h"
#import <CoreLocation/CoreLocation.h> // MARK: QUESTION FOR JON: Despite Importing this in my .h file I still have to import this here... Why?
#import "LSIWeatherIcons.h"
#import "LSIErrors.h"
#import "LSILog.h"
#import "LSIFileHelper.h"
#import "LSICardinalDirection.h"
#import "LSIWeatherForecast.h"
#import "HLOWeatherController.h"
#import "DailyTableViewCell.h"
#import "HourlyCollectionViewCell.h"

@interface HLOWeatherViewController () <CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource> {
    BOOL _requestedLocation;
}
// MARK:- Properties

@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;
//@property (nonatomic) LSIWeatherForecast *forecast; // Won't be needing this as we'll be using a controller.
@property (nonatomic) HLOWeatherController *weatherController;

// Outlets

// MARK:- Top View
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;

// MARK:- Little details at the bottom of top view. What do I call those lol
@property (strong, nonatomic) IBOutlet UILabel *currentDayLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentTopTemp;
@property (strong, nonatomic) IBOutlet UILabel *currentLowTemp;

// MARK:- Table and Collection
@property (strong, nonatomic) IBOutlet UITableView *dailyTable;
@property (strong, nonatomic) IBOutlet UICollectionView *hourlyCollection;

- (IBAction)fetchAPITapped:(UIButton *)sender;

// MARK:- Actions
@end

// MARK:- QUESTION FOR JON: So when I didn't have '()' it was giving me an error. What exactly does the '()' mean to the compiler.
// Well I learned that putting something inside of the '()' is like making a form of extension on whatever you put in there? So like a global extension? Still confused lowkey.
//@interface HLOWeatherViewController () <CLLocationManagerDelegate, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource>
//@end

@implementation HLOWeatherViewController

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

    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    [self initializeController];
    self.hourlyCollection.delegate = self;
    self.hourlyCollection.dataSource = self;
    self.dailyTable.delegate = self;
    self.dailyTable.dataSource = self;

    [self updateViews];

}

//https://developer.apple.com/documentation/corelocation/converting_between_coordinates_and_user-friendly_place_names
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

- (void)requestWeatherForLocation:(CLLocation *)location {

}

- (void)updateViews {
    if (self.placemark) {
        // TODO: Update the City, State label
        [self.dailyTable reloadData];
        [self.hourlyCollection reloadData];

        self.locationLabel.text = self.placemark.country;
        self.summaryLabel.text = self.weatherController.currentForecast.summary;
        self.temperatureLabel.text = [NSString stringWithFormat:@"%d°", self.weatherController.currentForecast.temperature.intValue];
        NSDate *date = [[NSDate alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE"];

        self.currentDayLabel.text = [dateFormatter stringFromDate:date];
        // MARK:- QUESTION FOR JON: Idk what to do for the bottom right numbers? Could I get some help or what I was supposed to put in there?
    }

    // TODO: Update the UI based on the current forecast
}

// MARK:- Methods

// MARK:- QUESTION FOR JON: You mentioned that I shouldn't call _variable outside of initializers.... would this count as an initializer? lol
- (void)initializeController {
    if (!_weatherController) {
        _weatherController = [[HLOWeatherController alloc] init];
        [self.weatherController parseJSONData:loadFile(@"Weather.json", [LSIWeatherForecast class]) completionBloc:^(NSError * _Nullable error) {
            [self updateViews];
        }];
    }
}


// MARK:- Actions
- (void)fetchAPITapped:(UIButton *)sender {
    //    [self.weatherController fetchForecastWithLatitude:self.location.coordinate.latitude longitude:self.location.coordinate.latitude];
        [self.weatherController fetchForecastWithLatitude:self.location.coordinate.latitude longitude:self.location.coordinate.longitude completionBloc:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error fetching weatherApi: %@", error);
                return;
            }
            [self updateViews];
        }];
    //    [self.weatherController parseJSONData:loadFile(@"Weather.json", [LSIWeatherForecast class]) completionBloc:^(NSError * _Nullable error) {
    //
    //    }];
}

// MARK:- Protocol conforming

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
    DailyTableViewCell *cell = (DailyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DailyCell" forIndexPath:indexPath];

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
    HourlyCollectionViewCell *cell = (HourlyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HourlyCell" forIndexPath:indexPath];

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

@end
// ^ I really like that "implementation" for a class ends with @end.
// Makes it easy to code within the scope.
