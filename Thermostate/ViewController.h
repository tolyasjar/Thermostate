//
//  ViewController.h
//  Thermostate
//
//  Created by Toleen Jaradat on 6/16/16.
//  Copyright © 2016 Toleen Jaradat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@end
bool isItCelsius;
int backgroundValue;

CLLocationManager *locationManager;



