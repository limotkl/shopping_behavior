//
//  preViewController.m
//  LIGPS
//
//  Created by Fang LI on 4/17/17.
//  Copyright © 2017 Fang LI. All rights reserved.
//

#import "preViewController.h"
#import "ViewController.h"
@interface preViewController ()

@end

@implementation preViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]; // Declare the Gesture.
    gesRecognizer.delegate = self;
    [self.view addGestureRecognizer:gesRecognizer];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submit:(id)sender {
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ViewController *tvc;
    tvc = [segue destinationViewController];
    tvc.strlabel3 = _TFname.text;
    tvc.strIP = _TFpassword.text;
}
@end
