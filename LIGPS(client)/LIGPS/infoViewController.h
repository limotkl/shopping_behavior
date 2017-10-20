//
//  infoViewController.h
//  LIGPS
//
//  Created by Fang LI on 4/17/17.
//  Copyright © 2017 Fang LI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface infoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *detail;
//@property (weak, nonatomic) IBOutlet UILabel *background;
@property (weak, nonatomic) IBOutlet UILabel *back;

@property (weak, nonatomic) IBOutlet UILabel *nameofshop;

@property (weak, nonatomic) IBOutlet UITextView *text;

@property (weak, nonatomic) NSString *strdetail;
@property (weak, nonatomic) NSString *strback;

@end
