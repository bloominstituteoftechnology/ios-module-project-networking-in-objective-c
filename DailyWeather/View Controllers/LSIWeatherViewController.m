//
//  LSIWeatherViewController.m
//
//  Created by Paul Solt on 2/6/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "LSIWeatherViewController.h"
#import "../Helpers/LSIWeatherIcons.h"
#import "../Helpers/LSICardinalDirection.h"
#import "../LambdaSDK/LSIErrors.h"
#import "../LambdaSDK/LSILog.h"
#import "../LambdaSDK/LSIFileHelper.h"
#import "../Model/LSIWeatherForcast.h"
#import "../Model/LSICurrentForecast.h"

@interface LSIWeatherViewController () {
    BOOL _requestedLocation;
}

// Properties
@property CLLocationManager *locationManager;
@property CLLocation *location;
@property (nonatomic) CLPlacemark *placemark;

@property (nonatomic) LSICurrentForecast *currentForecast;

// IBOutlets
@property (nonatomic) IBOutlet UIToolbar *toolbar;

@property (nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic) IBOutlet UILabel *cityAndStateLabel;
@property (nonatomic) IBOutlet UILabel *summaryLabel;
@property (nonatomic) IBOutlet UILabel *temperatureLabel;

@property (nonatomic) IBOutlet UILabel *windLabel;
@property (nonatomic) IBOutlet UILabel *humidityPercentageLabel;
@property (nonatomic) IBOutlet UILabel *chanceOfRainLabel;
@property (nonatomic) IBOutlet UILabel *apparentTemperatureLabel;
@property (nonatomic) IBOutlet UILabel *pressureLabel;
@property (nonatomic) IBOutlet UILabel *uvIndexLabel;

@end

// NOTE: You must declare the Category before the main implementation,
// otherwise you'll see errors about the type not being correct if you
// try to move delegate methods out of the main implementation body
@interface LSIWeatherViewController (CLLocationManagerDelegate) <CLLocationManagerDelegate>

@end


@implementation LSIWeatherViewController

BOOL shouldBypassNetworkingRequest = YES; // YES to load weather data from local JSON file, NO to make networking request

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
    
    [self.toolbar setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.toolbar setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];
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
    
    if (shouldBypassNetworkingRequest) {
        // Parse CurrentWeather.json from App Bundle and update UI
        NSData *weatherData = loadFile(@"CurrentWeather.json", [LSIWeatherViewController class]);
        
        NSError *jsonError = nil;
        NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&jsonError]; // NSError **
        
        if (!weatherDictionary) {
            NSLog(@"We've got an error: %@", jsonError);
        }
        
        if (![weatherDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"weatherDictionary is not a dictionary!");
            return;
        }
        
        self.currentForecast = [[LSICurrentForecast alloc] initWithDictionary:weatherDictionary];
        
    } else {
        // TODO: 2. Refactor and Parse Weather.json from App Bundle and update UI
        
    }
    
    [self updateViews];
}

- (void)updateViews {
    if (self.placemark) {
        // TODO: Update the City, State label
        self.cityAndStateLabel.text = [NSString stringWithFormat:@"%@, %@", self.placemark.locality, self.placemark.administrativeArea];
    }
    
    // TODO: Update the UI based on the current forecast
    NSString *iconName = self.currentForecast.icon;
    UIImage *icon = [LSIWeatherIcons weatherImageForIconName:iconName];
    self.iconImageView.image = icon;
    
    NSString *temperature = [NSString stringWithFormat:@"%.0f°F", self.currentForecast.temperature];
    self.temperatureLabel.text = temperature;
    
    NSString *windDirection = [LSICardinalDirection directionForHeading:self.currentForecast.windBearing];
    NSString *windSpeed = [NSString stringWithFormat:@"%.0f", self.currentForecast.windSpeed];
    self.windLabel.text = [NSString stringWithFormat:@"%@ %@ mph", windDirection, windSpeed];
    
    NSString *humidity = [NSString stringWithFormat:@"%.0f", self.currentForecast.humidity*100];
    self.humidityPercentageLabel.text = [NSString stringWithFormat:@"%@%%", humidity];
    
    NSString *precipProbability = [NSString stringWithFormat:@"%.0f", self.currentForecast.precipProbability*100];
    self.chanceOfRainLabel.text = [NSString stringWithFormat:@"%@%%", precipProbability];
    
    NSString *apparentTemperature = [NSString stringWithFormat:@"%.0f°", self.currentForecast.apparentTemperature];
    self.apparentTemperatureLabel.text = apparentTemperature;
    
    double pressureInMillibars = self.currentForecast.pressure;
    NSString *pressureInInchesOfMercury = [NSString stringWithFormat:@"%.2f", pressureInMillibars * 0.02953];
    self.pressureLabel.text = [NSString stringWithFormat:@"%@ inHg", pressureInInchesOfMercury];
    
    NSString *uvIndex = [NSString stringWithFormat:@"%.0f", self.currentForecast.uvIndex];
    self.uvIndexLabel.text = [NSString stringWithFormat:@"%@", uvIndex];
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
