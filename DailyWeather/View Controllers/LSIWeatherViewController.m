
//
//  LSIWeatherViewController.m
//
//  Created by Paul Solt on 2/6/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "LSIWeatherViewController.h"
#import "LSIWeatherIcons.h"
#import "LSIErrors.h"
#import "LSILog.h"
#import "LSICurrenWeatherMock.h"
#import "LSIFileHelper.h"
#import "LSICardinalDirection.h"
#import "CurrentLocationWeatherFetcher.h"
#import "CurrentUserLocationWeather.h"




@interface LSIWeatherViewController ()
{
    BOOL _requestedLocation;
}
//MARK:- Properties

@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;

@property (nonatomic) CurrentLocationWeatherFetcher *currentWeatherFetcher;


//MARK:- IBOutlets

@property (strong, nonatomic) IBOutlet UIImageView *weatherSymbolImageView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (strong, nonatomic) IBOutlet UIToolbar *bottomToolBar;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;
@property (weak, nonatomic) IBOutlet UILabel *highTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowTempLabel;

@end

// NOTE: You must declare the Category before the main implementation,
// otherwise you'll see errors about the type not being correct if you
// try to move delegate methods out of the main implementation body
@interface LSIWeatherViewController (CLLocationManagerDelegate) <CLLocationManagerDelegate>

@end

@implementation LSIWeatherViewController

- (CurrentLocationWeatherFetcher *)currentWeatherFetcher
{
    if (!_currentWeatherFetcher)
    {
        _currentWeatherFetcher = [[CurrentLocationWeatherFetcher alloc] init];
    }
    return _currentWeatherFetcher;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HoulyWeatherCell" forIndexPath:indexPath];
    return cell;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DailyWeatherCell" forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return self;
}

- (IBAction)toolBarPressed:(UIBarButtonItem *)sender
{
    NSLog(@"Hello");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.currentWeatherFetcher fetchCurrentWeatherUsingLatitude:_locationManager.location.coordinate.latitude longtitude:_locationManager.location.coordinate.longitude completionBlock:^(CurrentUserLocationWeather *_Nullable weather, NSError * _Nullable error) {
        if (error) {   NSLog(@"Error fetching weather: %@",error); return; }
        NSLog(@"Weather: %@", weather);
        if (weather) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.temperatureLabel.text = [NSString stringWithFormat:@"%.f %@",weather.temperature,@"°F"];
                self.summaryLabel.text = weather.summary;
                self.weatherSymbolImageView.image = [UIImage imageNamed:weather.icon];
                
                [self requestCurrentPlacemarkForLocation:self.locationManager.location withCompletion:^(CLPlacemark *address, NSError *error) {
                    if (error) {
                        NSLog(@"%@",error);
                    }
                    self.locationLabel.text = [address subAdministrativeArea];
                    
                }];
            });
            
        }
    }];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _collectionView.dataSource = self;
    _collectionView.dataSource = self;
    [self decodeDataAndUpdateViews];
    
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    // TODO: Transparent toolbar with info button (Settings)
    // TODO: Handle settings button pressed
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
- (void)decodeDataAndUpdateViews {
    NSData *currentWeatherData = loadFile(@"CurrentWeather.json", [LSIWeatherViewController class]);
    NSError *error = nil;
    NSDictionary *currentWeatherJSON = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:0 error: &error ];
    LSICurrenWeatherMock * currentWeather = [[LSICurrenWeatherMock alloc] initWithDictionary:currentWeatherJSON];
    
    self.temperatureLabel.text = [NSString stringWithFormat:@"%.2f%@",currentWeather.temperature,@"°F"];
    
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
}

- (void)requestWeatherForLocation:(CLLocation *)location {
    
    // TODO: 1. Parse CurrentWeather.json from App Bundle and update UI
    
    
    
    
    // TODO: 2. Refactor and Parse Weather.json from App Bundle and update UI
}

- (void)updateViews {
    if (self.placemark) {
        // TODO: Update the City, State label
    }
    
    // TODO: Update the UI based on the current forecast
}

@end

/// MARK: CLLocationManagerDelegate Methods

@implementation LSIWeatherViewController(CLLocationManagerDelegate)

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


@end
