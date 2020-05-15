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
#import "CBDCurrentForcast.h"
#import "CBDHourlyForcast.h"
#import "CBDDailyForcast.h"
#import "LSIFileHelper.h"
#import "LSICardinalDirection.h"
#import "CBDWeatherFetcher.h"
#import "CBDWeatherForecast.h"

@interface LSIWeatherViewController () {
    BOOL _requestedLocation;
}

//MARK: - Private Properties
@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;
//@property (nonatomic) CBDCurrentForcast *currentForcast;
@property (nonatomic) CBDWeatherFetcher *fetcher;
@property (nonatomic) CBDWeatherForecast *forcast;

// MARK: - IBOutlets
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *windLabel;
@property (strong, nonatomic) IBOutlet UILabel *humidityLabel;
@property (strong, nonatomic) IBOutlet UILabel *precipProbabilityLabel;
@property (strong, nonatomic) IBOutlet UILabel *apparentTemperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *pressureLabel;
@property (strong, nonatomic) IBOutlet UILabel *uvIndexLabel;

@end

// NOTE: You must declare the Category before the main implementation,
// otherwise you'll see errors about the type not being correct if you
// try to move delegate methods out of the main implementation body
@interface LSIWeatherViewController (CLLocationManagerDelegate) <CLLocationManagerDelegate>

@end


@implementation LSIWeatherViewController

// MARK: - IBActions
- (IBAction)getInformation:(id)sender {
}


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
    self.locationLabel.text = @"-";
    
    [self requestWeatherForLocation:self.location];
//    [self updateViews];
    
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
    /*
    NSData *currentForcastData = loadFile(@"CurrentWeather.json", [LSIWeatherViewController class]);
    NSLog(@"Current Weather: %@", currentForcastData);
    NSError *jsonError = nil;
    NSDictionary *currentWeatherDictionary = [NSJSONSerialization JSONObjectWithData:currentForcastData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }
    NSLog(@"JSON: %@", currentWeatherDictionary);
    _currentForcast = [[CBDCurrentForcast alloc] initWithDictionary:currentWeatherDictionary];
    NSLog(@"Current Weather: %@", self.currentForcast);
     */
    
    // TODO: 2. Refactor and Parse Weather.json from App Bundle and update UI
    [self.fetcher fetchWeatherAtLatitude:_location.coordinate.latitude longitude:_location.coordinate.longitude completionBlock:^(CBDWeatherForecast * _Nullable forcast, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Weather Fetching Error: %@", error);
            return;
        }

        NSLog(@"Fetched weather: %@", forcast);
        self.forcast = forcast;
        
         __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    }];
}

- (void)updateViews {
    if (self.placemark) {
        NSString *administrativeArea;
        if (self.placemark.administrativeArea) {
            administrativeArea = self.placemark.administrativeArea;
        } else if (self.placemark.country) {
            administrativeArea = self.placemark.country;
        } else {
            administrativeArea = @" ";
        }
        
        self.locationLabel.text = [NSString stringWithFormat:@"%@, %@", self.placemark.locality, administrativeArea] ;
    }
    
    // TODO: Update the UI based on the current forecast
    self.iconImageView.image = [LSIWeatherIcons weatherImageForIconName:self.forcast.currentForecast.icon];
    self.summaryLabel.text = self.forcast.currentForecast.summary;
    
    double temperature = round([self.forcast.currentForecast.temperature doubleValue]);
    self.temperatureLabel.text = [NSString stringWithFormat:@"%0.0f\u00B0 F", temperature];
    
    double windSpeed = round([self.forcast.currentForecast.windSpeed doubleValue]);
    double windbearing = round([self.forcast.currentForecast.windBearing doubleValue]);
    NSString *direction = [LSICardinalDirection directionForHeading:windbearing];
    self.windLabel.text = [NSString stringWithFormat:@"%@ %0.0f mph", direction, windSpeed];
    
    double humidity = [self.forcast.currentForecast.humidity doubleValue] * 100.0;
    self.humidityLabel.text = [NSString stringWithFormat:@"%0.0f%%", humidity];
    
    double precipProbability = round([self.forcast.currentForecast.precipProbability doubleValue]);
    self.precipProbabilityLabel.text = [NSString stringWithFormat:@"%0.0f%%", precipProbability];
    
    double apparentTemperature = round([self.forcast.currentForecast.apparentTemperature doubleValue]);
    self.apparentTemperatureLabel.text = [NSString stringWithFormat:@"%0.0f\u00B0 F", apparentTemperature];
    
    double pressure = round([self.forcast.currentForecast.pressure doubleValue]);
    self.pressureLabel.text = [NSString stringWithFormat:@"%0.1f inHg", pressure];
    
    double uvIndex = round([self.forcast.currentForecast.uvIndex doubleValue]);
    self.uvIndexLabel.text = [NSString stringWithFormat:@"%0.0f", uvIndex];
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

- (CBDWeatherFetcher *)fetcher {
    if (!_fetcher) {
        _fetcher = [[CBDWeatherFetcher alloc] init];
    }
    return _fetcher;
}

@end


