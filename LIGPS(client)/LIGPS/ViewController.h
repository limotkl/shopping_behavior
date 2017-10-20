//
//  ViewController.h
//  LIGPS
//
//  Created by Fang LI on 2/25/17.
//  Copyright © 2017 Fang LI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CFNetwork/CFNetwork.h>
#import <SystemConfiguration/SystemConfiguration.h>
@interface ViewController : UIViewController
//@interface ViewController : UIViewController<CLLocationManagerDelegate>
//============
@property (weak, nonatomic) NSString *strIP;
@property (weak, nonatomic) NSString *strlabel3;
@property (nonatomic, retain) NSInputStream *inputStream;
@property (nonatomic, retain) NSOutputStream *outputStream;
- (IBAction)detail:(id)sender;
- (void) initNetworkCommunication;
//=============
@property(nonatomic,retain) CLLocationManager* locationmanager;
@end

