//
//  targetViewController.h
//  LIGPS
//
//  Created by Fang LI on 4/17/17.
//  Copyright © 2017 Fang LI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface targetViewController : UIViewController{
    MKMapView *mapview;
}

@property (strong,nonatomic) IBOutlet MKMapView *mapview;

@property (weak, nonatomic) IBOutlet UILabel *information;
@property (weak, nonatomic) IBOutlet UILabel *information1;
@property (weak, nonatomic) IBOutlet UILabel *information2;

@property (weak, nonatomic) NSString *strsegment0;
@property (weak, nonatomic) NSString *strsegment1;
@property (weak, nonatomic) NSString *strsegment2;


@property(nonatomic,retain) CLLocationManager* locationmanager;

- (IBAction)click:(id)sender;
- (IBAction)click1:(id)sender;
- (IBAction)click2:(id)sender;


@end
