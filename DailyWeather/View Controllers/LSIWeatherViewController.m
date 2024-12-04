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
#import "LSICurrentForecast.h"
#import "LSIFileHelper.h"
#import "LSICardinalDirection.h"
#import "LSIWeatherResults.h"
#import "WeatherFetcher.h"

@interface LSIWeatherViewController () {
    BOOL _requestedLocation;
}

@property (weak, nonatomic) IBOutlet UIImageView *weatherIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *apparentTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *precipitationProbabilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *uvIndexLabel;


@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;
@property (nonatomic)WeatherFetcher *weatherFetcher;
@property (nonatomic)LSICurrentForecast *currentForecast;

@end

// NOTE: You must declare the Category before the main implementation,
// otherwise you'll see errors about the type not being correct if you
// try to move delegate methods out of the main implementation body
@interface LSIWeatherViewController (CLLocationManagerDelegate) <CLLocationManagerDelegate>

@end


@implementation LSIWeatherViewController



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
    
    WeatherFetcher *weatherFetcher = [[WeatherFetcher alloc] init];
    
    [weatherFetcher fetchWeatherWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude completionHandler:^(LSIWeatherResults * _Nullable results, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.currentForecast = results.currentForecast;
            NSLog(@"Got this error %@", error);
            NSLog(@"Got this current forecast %@", results.currentForecast);
            NSLog(@"Got this current forecast %f", results.currentForecast.apparentTemperature);
        
            [self updateViews];
        });
    }];
    
    
//    NSData *weatherData = loadFile(@"Weather.json", LSIWeatherViewController.class);
//
//    NSError *weatherJsonError = nil;
//    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData
//                                                                             options:0
//                                                                               error:&weatherJsonError];
//
//    if (!weatherDictionary) {
//        NSLog(@"Error with weather json: %@", weatherJsonError);
//    }
//
//    if (![weatherDictionary isKindOfClass:NSDictionary.class]) {
//        NSLog(@"current weather dictionary isn't a dictionary");
//    }
//
//    LSIWeatherResults *weatherResults = [[LSIWeatherResults alloc] initWithDictionary:weatherDictionary];
//    LSICurrentForecast *currentForecast = weatherResults.currentForecast;
    
//    UIImage *icon = [LSIWeatherIcons weatherImageForIconName:self.currentForecast.icon];
//    _weatherIconImageView.image = icon;
//
//    _summaryTextLabel.text = self.currentForecast.summary;
//    _currentTemperatureLabel.text = [NSString stringWithFormat:@"%.0fºF", round(self.currentForecast.temperature)];
//
//    NSString *windDirection = [LSICardinalDirection directionForHeading:self.currentForecast.windBearing];
//    NSString *windSpeed = [NSString stringWithFormat:@"%.0f", self.currentForecast.windSpeed];
//    NSString *windSpeedText = [NSString stringWithFormat:@"%@ %@ mph", windDirection, windSpeed];
//    _windSpeedLabel.text = windSpeedText;
//
//    _humidityLabel.text = [NSString stringWithFormat:@"%.0f%%", self.currentForecast.humidity * 100];
//    _precipitationProbabilityLabel.text = [NSString stringWithFormat:@"%.0f%%", self.currentForecast.precipProbability * 100];
//
//    _apparentTemperatureLabel.text = [NSString stringWithFormat:@"%.0fºF", round(self.currentForecast.apparentTemperature)];
//    _pressureLabel.text = [NSString stringWithFormat:@"%.2f inHg", self.currentForecast.pressure];
//    _uvIndexLabel.text = [NSString stringWithFormat:@"%.0f", round(self.currentForecast.uvIndex)];
    
}

- (void)updateViews {
    if (self.placemark) {
        _locationTextLabel.text = _placemark.name;
    }
    
    UIImage *icon = [LSIWeatherIcons weatherImageForIconName:self.currentForecast.icon];
    _weatherIconImageView.image = icon;
    
    _summaryTextLabel.text = self.currentForecast.summary;
    _currentTemperatureLabel.text = [NSString stringWithFormat:@"%.0fºF", round(self.currentForecast.temperature)];
    
    NSString *windDirection = [LSICardinalDirection directionForHeading:self.currentForecast.windBearing];
    NSString *windSpeed = [NSString stringWithFormat:@"%.0f", self.currentForecast.windSpeed];
    NSString *windSpeedText = [NSString stringWithFormat:@"%@ %@ mph", windDirection, windSpeed];
    _windSpeedLabel.text = windSpeedText;
    
    _humidityLabel.text = [NSString stringWithFormat:@"%.0f%%", self.currentForecast.humidity * 100];
    _precipitationProbabilityLabel.text = [NSString stringWithFormat:@"%.0f%%", self.currentForecast.precipProbability * 100];
    
    _apparentTemperatureLabel.text = [NSString stringWithFormat:@"%.0fºF", round(self.currentForecast.apparentTemperature)];
    _pressureLabel.text = [NSString stringWithFormat:@"%.2f inHg", self.currentForecast.pressure];
    _uvIndexLabel.text = [NSString stringWithFormat:@"%.0f", round(self.currentForecast.uvIndex)];
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
