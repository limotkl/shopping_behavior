//
//  targetViewController.m
//  LIGPS
//
//  Created by Fang LI on 4/17/17.
//  Copyright © 2017 Fang LI. All rights reserved.
//

#import "targetViewController.h"
#import "infoViewController.h"
@interface targetViewController ()

@end

@implementation targetViewController
@synthesize mapview;
@synthesize locationmanager;
@synthesize strsegment0,strsegment1,strsegment2;
@synthesize information,information1,information2;

NSString * fromserver1=@"null";
NSString * infoback=@"null";

NSString * info0=@"null";
NSString * info1=@"null";
NSString * info2=@"null";

NSString * infoback0=@"null";
NSString * infoback1=@"null";
NSString * infoback2=@"null";

//int flag = 0;
- (void)viewDidLoad{
    
    [super viewDidLoad];
    //===============
    mapview.showsUserLocation = YES;
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=1000.0f;
    [locationManager startUpdatingLocation];
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta=0.008;
    theSpan.longitudeDelta=0.008;
    MKCoordinateRegion theRegion;
    theRegion.center=[[locationManager location] coordinate];
    theRegion.span=theSpan;
    [mapview setRegion:theRegion];

    
    //==================label information
    //segment 再分割
    NSArray *namelist0= [strsegment0 componentsSeparatedByString:@"^"];
    information.text = namelist0[0];
    info0 = namelist0[1];
    infoback0 = namelist0[0];
    UIButton *button0 = (UIButton *)[self.view viewWithTag:1];
    [self setbackground:namelist0[0] tobutton:button0];

   
    NSArray *namelist1= [strsegment1 componentsSeparatedByString:@"^"];
    information1.text = namelist1[0];
    info1 = namelist1[1];
    infoback1 = namelist1[0];
    UIButton *button1 = (UIButton *)[self.view viewWithTag:2];
    [self setbackground:namelist1[0] tobutton:button1];
    
    
    NSArray *namelist2= [strsegment2 componentsSeparatedByString:@"^"];
    information2.text = namelist2[0];
    info2 = namelist2[1];
    infoback2 = namelist2[0];
    UIButton *button2 = (UIButton *)[self.view viewWithTag:3];
    [self setbackground:namelist2[0] tobutton:button2];
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setbackground:(NSString*) name tobutton:(UIButton *) buttonback{
    //============1
    if ([name isEqualToString:@"target"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"target.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=0;
        return;
    }
    //============2
    if ([name isEqualToString:@"weis"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"weis.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=1;
        return;
    }
    //============3
    if ([name isEqualToString:@"Walmart"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"walmart.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    //============4
    if ([name isEqualToString:@"art museum"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"art.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    //============5
    if ([name isEqualToString:@"Department of MS"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"departmentMS.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    //============6
    if ([name isEqualToString:@"dickinson"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"dickinsoncollege.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    //============7
    if ([name isEqualToString:@"library"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"library.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    //============8
    if ([name isEqualToString:@"lot area"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"lot_area.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }

    //============9
    if ([name isEqualToString:@"newing college"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"newingcollege.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    //============10
    if ([name isEqualToString:@"science library"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"sl.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    //============11
    if ([name isEqualToString:@"student wings"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"sw.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    //============12
    if ([name isEqualToString:@"university union"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"uu.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    
    
    //============13
    if ([name isEqualToString:@"AMC"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"AMC.jpeg"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    //============14
    if ([name isEqualToString:@"A.C.Moore"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"ACMoore.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    //============15
    if ([name isEqualToString:@"T.J.Maxx"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"TJMAX.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    //============16
    if ([name isEqualToString:@"Sams Club"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"sam's.jpeg"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    //============17
    if ([name isEqualToString:@"TGI Fridats"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"friday.jpeg"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    //============18
    if ([name isEqualToString:@"sweetFrog"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"sweet.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    //============19
    if ([name isEqualToString:@"Dicks Sporting"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"dick's.jpeg"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    //============20
    if ([name isEqualToString:@"Barnes Noble"])
    {
        UIImage *btnImage = [UIImage imageNamed:@"BOOK.jpeg"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        //flag=2;
        return;
    }
    else
    {
        UIImage *btnImage = [UIImage imageNamed:@"submit.png"];
        [buttonback setBackgroundImage:btnImage forState:UIControlStateNormal];
        return;
    }
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)click:(id)sender {
    fromserver1 = info0;
    infoback = infoback0 ;
}

- (IBAction)click1:(id)sender {
    fromserver1 = info1;
    infoback= infoback1;
}

- (IBAction)click2:(id)sender {
    fromserver1 = info2;
    infoback = infoback2;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
        infoViewController *info;
        info = [segue destinationViewController];
        info.strdetail = fromserver1;
        info.strback = infoback ;
    
}
@end
