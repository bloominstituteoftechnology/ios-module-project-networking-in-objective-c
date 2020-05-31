////
////  LSIWeatherViewController.m
////
////  Created by Paul Solt on 2/6/20.
////  Copyright © 2020 Lambda, Inc. All rights reserved.
////
//
//#import <CoreLocation/CoreLocation.h>
//#import "LSIWeatherViewController.h"
//#import "LSIWeatherIcons.h"
//#import "LSIErrors.h"
//#import "LSILog.h"
//#import "LSIWeatherForcast.h"
//#import "LSIHourlyForecast.h"
//#import "LSICurrentWeather.h"
//#import "LSIDailyForecast.h"
//#import "LSIFileHelper.h"
//#import "LSIWeatherIcons.h"
//#import "LSICardinalDirection.h"
//#import "LSIWeatherFetcher.h"
//
//@interface LSIWeatherViewController () {
//    BOOL _requestedLocation;
//}
//
//@property CLLocationManager *locationManager;
//@property CLLocation *location;
//@property (nonatomic) CLPlacemark *placemark;
////Outlets added Sal
//@property (weak, nonatomic) IBOutlet UIImageView *weatherIconImage;
//@property (weak, nonatomic) IBOutlet UILabel *cityStateLbl;
//@property (weak, nonatomic) IBOutlet UILabel *tempLbl;
//@property (weak, nonatomic) IBOutlet UILabel *summaryLbl;
//
//@property (weak, nonatomic) IBOutlet UILabel *windSpeedLbl;
//@property (weak, nonatomic) IBOutlet UILabel *humidityLbl;
//@property (weak, nonatomic) IBOutlet UILabel *chancesOfRainLbl;
//@property (weak, nonatomic) IBOutlet UILabel *feelsLikeLbl;
//@property (weak, nonatomic) IBOutlet UILabel *pressureLbl;
//@property (weak, nonatomic) IBOutlet UILabel *uvIndexLbl;
//
//
//@property LSIWeatherFetcher *fetcher;
//@property LSIWeatherForcast *currentWeather;
//
//
//@end
//
//// NOTE: You must declare the Category before the main implementation,
//// otherwise you'll see errors about the type not being correct if you
//// try to move delegate methods out of the main implementation body
//@interface LSIWeatherViewController (CLLocationManagerDelegate) <CLLocationManagerDelegate>
//
//@end
//
//
//@implementation LSIWeatherViewController
//
//BOOL shouldBypassNetworkingRequest = YES; // yes means load from local JSON File
//
//- (instancetype)initWithCoder:(NSCoder *)coder {
//    self = [super initWithCoder:coder];
//    if (self) {
//        _locationManager = [[CLLocationManager alloc] init];
//    }
//    return self;
//}
//
//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        _locationManager = [[CLLocationManager alloc] init];
//    }
//    return self;
//}
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    self.locationManager.delegate = self;
//    [self.locationManager requestWhenInUseAuthorization];
//    [self.locationManager startUpdatingLocation];
//    
//    //  Transparent toolbar with info button (Settings)
////  [self.toolbar setBackgroundImage:[UIImage new]
////                forToolbarPosition:UIBarPositionAny
////                        barMetrics:UIBarMetricsDefault];
////  [self.toolbar setShadowImage:[UIImage new]
////            forToolbarPosition:UIBarPositionAny];
//  
// 
//}
//
////https://developer.apple.com/documentation/corelocation/converting_between_coordinates_and_user-friendly_place_names
//- (void)requestCurrentPlacemarkForLocation:(CLLocation *)location
//                            withCompletion:(void (^)(CLPlacemark *, NSError *))completionHandler {
//    if (location) {
//        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//                
//        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//            if (error) {
//                completionHandler(nil, error);
//                return;
//            }
//            
//            if (placemarks.count >= 1) {
//                CLPlacemark *place = placemarks.firstObject;
//                
//                completionHandler(place, nil);
//                return;
//                
//            } else {
//                NSError *placeError = errorWithMessage(@"No places match current location", LSIPlaceError);
//                
//                completionHandler(nil, placeError);
//                return;
//            }
//        }];
//        
//    } else {
//        NSLog(@"ERROR: Missing location, please provide location");
//    }
//}
//
//- (void)requestUserFriendlyLocation:(CLLocation *)location {
//    if(!_requestedLocation) {
//        _requestedLocation = YES;
//        __block BOOL requestedLocation = _requestedLocation;
//        
//        [self requestCurrentPlacemarkForLocation:location withCompletion:^(CLPlacemark *place, NSError *error) {
//            
//            NSLog(@"Location: %@, %@", place.locality, place.administrativeArea);
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.location = location;
//                self.placemark = place;
//                [self updateViews];
//            });
//            requestedLocation = NO;
//        }];
//    }
//}
//
//- (void)requestWeatherForLocation:(CLLocation *)location {
//  
//  if (shouldBypassNetworkingRequest) {
////    Parse CurrentWeather.json from App Bundle and update UI
////    NSData *weatherData = loadFile(@"Weather.json", [LSIWeatherViewController class]);
//    NSData *weatherData = loadFile(@"Weather.json", [LSIWeatherForcast class]);
//    
//    NSError *jsonError = nil;
//    NSDictionary *currentDictionary = [NSJSONSerialization JSONObjectWithData:weatherData
//                                                                       options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
//                                                                         error:&jsonError];
//    if (!currentDictionary) {
//        NSLog(@"We have an error: %@", jsonError);
//      }
//      if (![currentDictionary isKindOfClass:[NSDictionary class]]) {
//        NSLog(@"Current Dictionary is not valid dictionary");
//        return;
//      }
//      LSIWeatherForcast *current = [[LSIWeatherForcast alloc] initWithDictionary:currentDictionary];
//      self.currentWeather = current;
//      
//  } else {
//    // TODO: 2. Refactor and Parse Weather.json from App Bundle and update UI
//  }
//  [self updateViews];
//  }
//
//- (void)updateViews {
//    if (self.placemark) {
//        // TODO: Update the City, State label
//      self.cityStateLbl.text = [NSString stringWithFormat:@"%@", self.placemark.locality,self.placemark.administrativeArea];
//    }
//    
//    // TODO: Update the UI based on the current forecast
//  //ICON
//  NSString *iconName = self.currentWeather.currently.icon;
//  UIImage *icon = [LSIWeatherIcons weatherImageForIconName:iconName];
//  self.weatherIconImage.image = icon;
//  
//  //TEMP LABEL
//  NSString *temperature = [NSString stringWithFormat:@"%.0f°F", self.currentWeather.currently.temperature];
// 
//  
//  self.tempLbl.text = temperature;
//  
//  //WIND DIRECTION SPEED
//  NSString *windDirection = [LSICardinalDirection directionForHeading:self.currentWeather.currently.windBearing];
//  NSString *windSpeed = [NSString stringWithFormat:@"%.0f", self.currentWeather.currently.windSpeed];
//  self.windSpeedLbl.text = [NSString stringWithFormat:@"%@ %@ MPH", windDirection, windSpeed];
//  
//  //Humidity
//  NSString *humidity = [NSString stringWithFormat:@"%.0f", self.currentWeather.currently.humidity*100];
//  self.humidityLbl.text = [NSString stringWithFormat:@"%@%%", humidity];
//  
//  //Chances for Rain
//  NSString *precipProbability = [NSString stringWithFormat:@"%.0f", self.currentWeather.currently.precipProbability*100];
//  self.chancesOfRainLbl.text = [NSString stringWithFormat:@"%@%%", precipProbability];
//  
//  //Apparent Temp
//  NSString *apparentTemp = [NSString stringWithFormat:@"%.0F°", self.currentWeather.currently.apparentTemperature];
//  self.feelsLikeLbl.text = apparentTemp;
//  
//  //Pressure
//  
//  double pressureinMillibar = self.currentWeather.currently.pressure;
//  NSString *pressureInInches = [NSString stringWithFormat:@"%.2F", pressureinMillibar * 0.02953];
//  self.pressureLbl.text = [NSString stringWithFormat:@"%@ inHg", pressureInInches];
//  
//  //UV
//  NSString *uvIndex = [NSString stringWithFormat:@"%.0F", self.currentWeather.currently.uvIndex];
//  self.uvIndexLbl.text = [NSString stringWithFormat:@"%@", uvIndex];
//  
//}
//
//@end
//
///// MARK: CLLocationManagerDelegate Methods
//
//@implementation LSIWeatherViewController(CLLocationManagerDelegate)
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//    NSLog(@"locationManager Error: %@", error);
//}
//
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
//    NSLog(@"locationManager: found location %@", locations.firstObject);
//    
//    CLLocation *location = locations.firstObject;
//    
//    // 1. Request Weather for location
//    
//    [self requestWeatherForLocation: location];
//    
//    // 2. Request User-Friendly Place Names for Lat/Lon coordinate
//    
//    [self requestUserFriendlyLocation: location];
//    
//    // Stop updating location after getting one (NOTE: this is faster than doing a single location request)
//    [manager stopUpdatingLocation];
//}
//
//@end
