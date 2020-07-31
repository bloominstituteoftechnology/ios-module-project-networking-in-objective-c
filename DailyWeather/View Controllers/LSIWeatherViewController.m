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
#import "LSIFileHelper.h"
#import "LSICurrentForecast.h"
#import "LSICardinalDirection.h"
#import "LSIWeatherForecast.h"

@interface LSIWeatherViewController () {
    BOOL _requestedLocation;
}
@property (nonatomic)LSIWeatherForecast *weatherForecastFetcher;
@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;
@property (nonatomic) LSICurrentForecast *currentForecast;


@property (weak, nonatomic) IBOutlet UIImageView *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *chanceOfRainLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelsLikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *uvIndexLabel;
@property (weak, nonatomic) IBOutlet UISwitch *searchUsingApiSwitch;

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

- (LSIWeatherForecast *)weatherForecastFetcher {
    if (!_weatherForecastFetcher) {
        _weatherForecastFetcher = [[LSIWeatherForecast alloc] init];
    }
    return _weatherForecastFetcher;
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
//    NSData *currentWeatherData = loadFile(@"CurrentWeather.json", [LSIWeatherViewController class]);
//    NSLog(@"currentWeather: %@", currentWeatherData);
//
//    NSError *jsonError = nil;
//    NSDictionary *currentWeatherDictionary = [NSJSONSerialization JSONObjectWithData:currentWeatherData options:0 error:&jsonError];
//
//    if (jsonError) {
//        NSLog(@"JSON parsing error %@", jsonError);
//    }
//
//    LSICurrentForecast *currentForecast = [[LSICurrentForecast alloc] initWithDictionary:currentWeatherDictionary];
//    self.currentForecast = currentForecast;
    
    
    // TODO: 2. Refactor and Parse Weather.json from App Bundle and update UI
    
    if (self.searchUsingApiSwitch.on) {
    
   
        
        
    } else {
        NSData *weatherData = loadFile(@"CurrentWeather.json", [LSIWeatherViewController class]);
        NSLog(@"currentWeather: %@", weatherData);
        
            NSError *jsonError = nil;
            NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&jsonError];
        
            if (jsonError) {
                NSLog(@"JSON parsing error %@", jsonError);
            }
        
            LSICurrentForecast *currentForecast = [[LSICurrentForecast alloc] initWithDictionary:weatherDictionary];
            self.currentForecast = currentForecast;
    }
    
    
}

- (void)updateViews {
    if (self.placemark) {
        // TODO: Update the City, State label
        
        UIImage *iconImage =  [LSIWeatherIcons weatherImageForIconName: self.currentForecast.icon];
        _iconLabel.image = iconImage;
        _temperatureLabel.text = [NSString stringWithFormat: @"%@ F°", self.currentForecast.temperature];
        _summaryLabel.text = [NSString stringWithFormat:@"%@", self.currentForecast.summary ];
        NSString *windBearingDouble = [LSICardinalDirection directionForHeading: self.currentForecast.windBearing.doubleValue];
        _windLabel.text = [NSString stringWithFormat: @"%@", windBearingDouble];
        _humidityLabel.text = [NSString stringWithFormat: @"%@%%", self.currentForecast.humidity];
        _chanceOfRainLabel.text = [NSString stringWithFormat: @"%@ %%", self.currentForecast.precipitationProbability];
        _pressureLabel.text = [NSString stringWithFormat: @"%@ inHg", self.currentForecast.pressure];
        _feelsLikeLabel.text = [NSString stringWithFormat: @"%@°", self.currentForecast.apparentTemperature];
        _uvIndexLabel.text = [NSString stringWithFormat: @"%@", self.currentForecast.uvIndex];
        
        
        
        
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
