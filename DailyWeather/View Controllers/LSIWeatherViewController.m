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
#import "CMDCurrentForecast.h"
#import "CMDHourlyForecast.h"
#import "CMDDailyForecast.h"
#import "LSIFileHelper.h"
#import "LSICardinalDirection.h"
#import "CMDWeatherFetcher.h"
#import "CMDWeatherForecast.h"

@interface LSIWeatherViewController () {
    BOOL _requestedLocation;
}

@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;
@property (nonatomic) CMDWeatherFetcher *fetcher;
@property (nonatomic) CMDWeatherForecast *forecast;

@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *tempLabel;
@property (strong, nonatomic) IBOutlet UILabel *windLabel;
@property (strong, nonatomic) IBOutlet UILabel *apparentLabel;
@property (strong, nonatomic) IBOutlet UILabel *humidyLabel;
@property (strong, nonatomic) IBOutlet UILabel *pressureLabel;
@property (strong, nonatomic) IBOutlet UILabel *rainProbLabel;
@property (strong, nonatomic) IBOutlet UILabel *uvLabel;

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
    
    // TODO: 1. Parse CurrentWeather.json from App Bundle and update UI
    
    
    
    
    // TODO: 2. Refactor and Parse Weather.json from App Bundle and update UI
    [self.fetcher fetchWeatherAtLatitude:_location.coordinate.latitude longitude:_location.coordinate.longitude completionBlock:^(CMDWeatherForecast * _Nullable forecast, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Weather Fetching Error: %@", error);
                return;
            }

        NSLog(@"Fetched weather: %@", forecast);
        self.forecast = forecast;
            
           
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
    
    self.iconImage.image = [LSIWeatherIcons weatherImageForIconName:self.forecast.currentForecast.icon];
    self.summaryLabel.text = self.forecast.currentForecast.summary;
    
    double temperature = round([self.forecast.currentForecast.temperature doubleValue]);
    self.tempLabel.text = [NSString stringWithFormat:@"%0.0f\u00B0 F", temperature];
    
    double windSpeed = round([self.forecast.currentForecast.windSpeed doubleValue]);
    double windbearing = round([self.forecast.currentForecast.windBearing doubleValue]);
    NSString *direction = [LSICardinalDirection directionForHeading:windbearing];
    self.windLabel.text = [NSString stringWithFormat:@"%@ %0.0f mph", direction, windSpeed];
    
    double humidity = [self.forecast.currentForecast.humidity doubleValue] * 100.0;
    self.humidyLabel.text = [NSString stringWithFormat:@"%0.0f%%", humidity];
    
    double precipProbability = round([self.forecast.currentForecast.precipProbability doubleValue]);
    self.rainProbLabel.text = [NSString stringWithFormat:@"%0.0f%%", precipProbability];
    
    double apparentTemperature = round([self.forecast.currentForecast.apparentTemperature doubleValue]);
    self.apparentLabel.text = [NSString stringWithFormat:@"%0.0f\u00B0 F", apparentTemperature];
    
    double pressure = round([self.forecast.currentForecast.pressure doubleValue]);
    self.pressureLabel.text = [NSString stringWithFormat:@"%0.1f inHg", pressure];
    
    double uvIndex = round([self.forecast.currentForecast.uvIndex doubleValue]);
    self.uvLabel.text = [NSString stringWithFormat:@"%0.0f", uvIndex];
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
