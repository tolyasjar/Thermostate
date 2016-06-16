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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isItCelsius = 1;
    backgroundValue=0;
    _degreeLabel.text = @"0";
    [self checkBackgroungColor: backgroundValue];
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
    
    
    switch (isItCelsius)
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
