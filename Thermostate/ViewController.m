//
//  ViewController.m
//  Thermostate
//
//  Created by Toleen Jaradat on 6/16/16.
//  Copyright © 2016 Toleen Jaradat. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,weak) IBOutlet UISlider *slider;
@property (nonatomic,weak) IBOutlet UILabel *degreeLabel;
@property (nonatomic,weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic,weak) IBOutlet UILabel *epicdegreeLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = (id)self;
    
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    
    [locationManager startUpdatingLocation];
    
    isItCelsius = 1;
    backgroundValue=0;
    self.degreeLabel.text = @"0";
    [self checkBackgroungColor: backgroundValue];
    
     }
-(void) newWeatherRequestWithLocationCoords:(CLLocationCoordinate2D)coords {
    
    NSURLSession *session = [NSURLSession sharedSession];
    //NSLog(@"%f",coords.longitude);
    //NSLog(@"%f",coords.latitude);
    
   //add coords.latitude coords.longitude;
    NSString *urlstring = [NSString stringWithFormat:@"https://api.forecast.io/forecast/8245ff052a610d6644d87157527b7146/%f,%f",coords.latitude,coords.longitude];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlstring] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
       // NSLog(@"%@", jsonData);
        
        NSData *currentData = [jsonData valueForKey:@"currently"];
        
        NSString *tempratureString = [currentData valueForKey:@"temperature"];
        
        float temperatureInFahrenheit = tempratureString.floatValue;
        
        NSLog(@"The temprature in New York: %.2f",temperatureInFahrenheit);
        
        NSString *x =  [NSString stringWithFormat:@"%.0f",temperatureInFahrenheit];
        self.epicdegreeLabel.text =  x;
        NSLog(@"%@",self.degreeLabel.text);
        
        //for houston @"https://api.forecast.io/forecast/8245ff052a610d6644d87157527b7146/29.760427,-95.369803"
    }];
   
    [dataTask resume];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *currentLocation = [locations lastObject];
    
    if (currentLocation != nil){
        CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
        [self newWeatherRequestWithLocationCoords:coords];
        
    }
}

-(IBAction)indexChanged:(UISegmentedControl *)sender
{
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
        {   isItCelsius = 1;
            float x = [self.degreeLabel.text floatValue];
            [self convertFahrenheitToCelsius:(x)];
            
        }
            break;
            
        case 1:
        {   isItCelsius = 0;
            float x = [self.degreeLabel.text floatValue];
            [self convertCelsiusToFahrenheit:(x)];
            
        }
            break;
            
        default: 
            break; 
    } 
}


-(IBAction) sliderValueChanged:(id) sender {
    
    int value = (int) self.slider.value;
    
    backgroundValue = value;
    
    [self checkBackgroungColor: backgroundValue];
    
    NSString *value2 = [NSString stringWithFormat:@"%d", value];

    self.degreeLabel.text = value2;
    
}

-(int) convertCelsiusToFahrenheit:(int) DegreeInCelsius {
    
    int DegreeInFahrenheit = (int) (DegreeInCelsius * 1.8)+32;
    backgroundValue = DegreeInFahrenheit;
    NSString *value = [NSString stringWithFormat:@"%d",DegreeInFahrenheit];
    self.degreeLabel.text = value;
    self.slider.value = DegreeInFahrenheit;
    [self checkBackgroungColor: backgroundValue];
    return DegreeInFahrenheit;
    
}

-(void) checkBackgroungColor:(int) backgroundValue {
    
    int x = (int) isItCelsius ;
    switch (x)
    {
        case 0:
        {if (backgroundValue >= 90){
            self.view.backgroundColor = [UIColor redColor];
        } else if (backgroundValue <=20){
            self.view.backgroundColor = [UIColor blueColor];
        } else {
            self.view.backgroundColor = [UIColor whiteColor];
        }

        }
            break;
            
        case 1:
        {
            if (backgroundValue >= 32){
                self.view.backgroundColor = [UIColor redColor];
            } else if (backgroundValue <= -6){
                self.view.backgroundColor = [UIColor blueColor];
            } else {
                self.view.backgroundColor = [UIColor whiteColor];
            }
        
        }
            break;
            
        default:
            break;
    }
}



-(int) convertFahrenheitToCelsius:(int) DegreeInFahrenheit {
    
    int DegreeInCelsius = (int) (DegreeInFahrenheit - 32)/1.8 ;
    backgroundValue = DegreeInCelsius;
    NSString *value = [NSString stringWithFormat:@"%d", DegreeInCelsius];
    self.degreeLabel.text = value;
    self.slider.value = DegreeInCelsius;
    [self checkBackgroungColor: backgroundValue];
    return DegreeInCelsius;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
