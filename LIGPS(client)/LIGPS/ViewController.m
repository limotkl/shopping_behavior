//
//  ViewController.m
//  LIGPS
//
//  Created by Fang LI on 2/25/17.
//  Copyright © 2017 Fang LI. All rights reserved.
//
#import "ViewController.h"
#import "targetViewController.h"
//#import "infoViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *tips;

@end

@implementation ViewController
@synthesize locationmanager;
@synthesize inputStream, outputStream;
@synthesize strlabel3;

//int i = 100;
int flag=0;
int flag1=0;
int net = 1;

NSString * segment0=@"null";
NSString * segment1=@"null";
NSString * segment2=@"null";


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationmanager = [[CLLocationManager alloc]init];
    [locationmanager setDesiredAccuracy:kCLLocationAccuracyBest];
    locationmanager.delegate = self;
    NSLog(@"start tracking");
    //开始定位
    if(net == 1)
    {
        [self initNetworkCommunication];
    }
    
    [locationmanager startUpdatingLocation];
    //[self readData];
    //[locationmanager stopUpdatingLocation];
  
    if([self.locationmanager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [self.locationmanager requestAlwaysAuthorization]; // 永久授权
        [self.locationmanager requestWhenInUseAuthorization]; //使用中授权
    }
    //定时发送
//    [NSTimer scheduledTimerWithTimeInterval:3.0
//                                     target:self
//                                   selector:@selector(loopset)
//                                   userInfo:nil
//                                    repeats:YES];
     _tips.text=@"ready!";
}

#pragma mark locationManager delegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"hello");
    //_tips.text=@"wait!";
    //打印出精度和纬度
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    _label3.numberOfLines = 0;// 值设定为0时，多行显示。
    _label3.text=strlabel3;
    NSLog(@"username:%@",strlabel3);
    NSLog(@"latitude：%f longitude：%f",coordinate.latitude,coordinate.longitude);

    if(flag==1)
    {
        flag=0;
        //发送数据给server
        //[outputStream open];
        //NSLog(@"iiiijasadhsjdkasdkaj");
        _tips.text=@" ";
        _tips.text=@"sending data... please wait.";

        if(net == 1)
        {
        float latitude=coordinate.latitude;
        float longitude=coordinate.longitude;
        NSString *lat= [NSString stringWithFormat:@"%f",latitude];
        NSString *lon= [NSString stringWithFormat:@"%f",longitude];
        NSString *str2= @"&";
        NSString *str3= @"12";
        NSString *string0 = [strlabel3 stringByAppendingString:lat];
        NSString *string = [string0 stringByAppendingString:lon];
        NSString *string1 = [string stringByAppendingString:str2];

        NSString *string2 = [str3 stringByAppendingString:string1];
            
        NSData *data=[string2 dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"message:%@",string2);
        [self.outputStream write:data.bytes maxLength:data.length];
        }
       
        //[self getSignalStrength];//获取Wi-Fi信号强度
        //=================== read
        NSString *test=@"TGI Fridats^ turkey hgdhdfdf fjjfjfhyj cvchhc eeszjhnb free with apple is a nice placs edrf hashdg adasda wweaszxc \n \n \n \n  hfkdhfghfn aaetddvb &AMC^ Guardians of the Galaxy Vol. 2 \n Standard \n 8:30pm \t 9:30pm\t 10:00pm \n 3D\n 7:30pm \t 9:00pm\t 10:30pm &Sams Club^ sssssss";
        if(net == 1)
        {
                    _tips.text=@"responding...";
                    //[inputStream open];
                    uint8_t buffer[5120];
                    NSInteger nLen=[self.inputStream read:buffer maxLength:5120];
                    NSData *data0=[NSData dataWithBytes:buffer length:nLen];
                    NSString *str0=[[NSString alloc] initWithData:data0 encoding:NSUTF8StringEncoding];
                    NSLog(@"readData:%@",str0);
                    test= str0;
        }
        //===========================read end

        //字符串分割三段，标识为&
        NSArray *list= [test componentsSeparatedByString:@"&"];
        segment0=list[0];
        segment1=list[1];
        segment2=list[2];
//        NSLog(@"segment0:%@",segment0);
//        NSLog(@"segment1:%@",segment1);
//        NSLog(@"segment2:%@",segment2);
        _tips.text=@"GO!";
    }
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSDictionary *locationInfo = [[NSDictionary alloc]init];
        for (CLPlacemark * placemark in placemarks) {
            locationInfo = [placemark addressDictionary];
        }
        NSString *messag=[NSString stringWithFormat:@"Your Coordinate: \nlatitude:%f \n longitude:%f",coordinate.latitude,coordinate.longitude];
        _label0.numberOfLines = 0;
        _label0.text=messag;

        NSString *state=[locationInfo objectForKey:@"State"];
        NSString *city=[locationInfo objectForKey:@"City"];
        NSString *street=[locationInfo objectForKey:@"Street"];
        NSString *info=[NSString stringWithFormat:@"Your Location: \n %@   %@   %@",street,city,state];
        _label1.text=info;
        _label1.numberOfLines = 0;// 值设定为0时，多行显示。
    }];
    
//    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    
//
    
    if(flag1==1)
    {
        flag1=0;
        //发送数据给server
        //[outputStream open];
        //NSLog(@"iiiijasadhsjdkasdkaj");
        if(net == 1)
        {
            float latitude=coordinate.latitude;
            float longitude=coordinate.longitude;
            NSString *lat= [NSString stringWithFormat:@"%f",latitude];
            NSString *lon= [NSString stringWithFormat:@"%f",longitude];
            NSString *str2= @"&";
            NSString *string0 = [strlabel3 stringByAppendingString:lat];
            NSString *string = [string0 stringByAppendingString:lon];
            NSString *string1 = [string stringByAppendingString:str2];
            NSData *data=[string1 dataUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"message:%@",string1);
            [self.outputStream write:data.bytes maxLength:data.length];
        }
        //=================== read
        NSString *test;
        if(net == 1)
        {
            //[inputStream open];
            uint8_t buffer[5120];
            NSInteger nLen=[self.inputStream read:buffer maxLength:5120];
            NSData *data0=[NSData dataWithBytes:buffer length:nLen];
            NSString *str0=[[NSString alloc] initWithData:data0 encoding:NSUTF8StringEncoding];
            NSLog(@"readData:%@",str0);
            test= str0;
        }
        //===========================read end
        
        //字符串分割三段，标识为&
        NSArray *list= [test componentsSeparatedByString:@"&"];
        segment0=list[0];
        segment1=list[1];
        segment2=list[2];
    }

}


//=========================================================================

//初始化8999

- (void) initNetworkCommunication {
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    NSLog(@"password:%@",_strIP);
        CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"149.125.103.184",8999, &readStream, &writeStream);
    
    
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
}


- (IBAction)button:(id)sender {
    if(flag1!=1)
    {
        NSLog(@"flag set to 1");
        flag=1;
        _tips.text=@"wait!";
    }
        //NSLog(@"flag set to 1");
        //flag=1;
        //_tips.text=@"wait!";
}

-(void)loopset

{
    flag1=1;
    NSLog(@"flag1 set to 1");
}

- (void)getSignalStrength{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSString *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    float signalStrength = [[dataNetworkItemView valueForKey:@"_wifiStrengthBars"] intValue];
    NSLog(@"signal %f", signalStrength);
    //NSString *strength= [NSString stringWithFormat:@"%f",signalStrength];
}




//================================================================================

#pragma mark- error
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

- (IBAction)detail:(id)sender {
    _tips.text=@"ready!";
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    targetViewController *ttvc;
    ttvc = [segue destinationViewController];
    ttvc.strsegment0= segment0;
    ttvc.strsegment1= segment1;
    ttvc.strsegment2= segment2;
}


@end





