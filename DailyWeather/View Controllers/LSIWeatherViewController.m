//
//  LSIWeatherViewController.m
//
//  Created by Paul Solt on 2/6/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "LSIWeatherViewController.h"
#import "LSIErrors.h"
#import "LSILog.h"
#import "CurrentWeather.h"


@interface LSIWeatherViewController () {
    BOOL _requestedLocation;
}

@property (nonatomic) CurrentWeather *currentWeather;
@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *precipChanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *apparentTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *uvLabel;




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
    [self updateViews];
    
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
    
     NSURL *currentWeatherURL = [[NSBundle mainBundle] URLForResource:@"CurrentWeather" withExtension:@"json"];
     NSData *jsonData = [NSData dataWithContentsOfURL:currentWeatherURL];
     NSError *error = nil;
     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    self.currentWeather = [[CurrentWeather alloc]initWithDictionary: json];
    [self updateViews];
    
    
    
    // TODO: 2. Refactor and Parse Weather.json from App Bundle and update UI
}

- (void)updateViews
{
    if (self.placemark && self.currentWeather) {
        // TODO: Update the City, State label
        
        
        NSNumber *tempNumber = [NSNumber numberWithDouble: self.currentWeather.temperature];
        NSNumber *wsNumber = [NSNumber numberWithDouble: self.currentWeather.windSpeed];
        NSNumber *humidityNumber = [NSNumber numberWithDouble: self.currentWeather.humidity];
        NSNumber *chanceRainNumber = [NSNumber numberWithDouble: self.currentWeather.precipProbability];
        NSNumber *feelsLikeNumber = [NSNumber numberWithDouble: self.currentWeather.apparentTemperature];
        NSNumber *pressureFromNumber = [NSNumber numberWithInt: self.currentWeather.pressure];
        NSNumber *uvNumber = [NSNumber numberWithInt: self.currentWeather.uvIndex];
        
        
        self.icon.image = self.currentWeather.icon;
        self.locationLabel.text = self.placemark.name;
        self.summaryLabel.text = self.currentWeather.summary;
        self.tempLabel.text = [tempNumber stringValue];
        self.windSpeedLabel.text = [wsNumber stringValue];
        self.humidityLabel.text = [humidityNumber stringValue];
        self.precipChanceLabel.text = [chanceRainNumber stringValue];
        self.apparentTempLabel.text = [feelsLikeNumber stringValue];
        self.pressureLabel.text = [pressureFromNumber stringValue];
        self.uvLabel.text = [uvNumber stringValue];
        
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

- (IBAction)info:(id)sender {
}
@end
