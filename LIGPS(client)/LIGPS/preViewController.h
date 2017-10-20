//
//  preViewController.h
//  LIGPS
//
//  Created by Fang LI on 4/17/17.
//  Copyright © 2017 Fang LI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface preViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *TFname;
@property (weak, nonatomic) IBOutlet UITextField *TFpassword;
- (IBAction)submit:(id)sender;
//@property (weak, nonatomic) NSString *strlabel3;
@end
