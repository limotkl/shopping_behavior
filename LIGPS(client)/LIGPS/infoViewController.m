//
//  infoViewController.m
//  LIGPS
//
//  Created by Fang LI on 4/17/17.
//  Copyright © 2017 Fang LI. All rights reserved.
//

#import "infoViewController.h"
@interface infoViewController ()

@end

@implementation infoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _detail.text = _strdetail;
    //=================
    _text.text = _strdetail;
    _text.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
    //=================
    _detail.numberOfLines = 0;
    _detail.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
    _detail.backgroundColor = [UIColor clearColor];
    
    _nameofshop.text = _strback;
    
    if ([_strback isEqualToString:@"target"]||[_strback isEqualToString:@"weis"])
    {
        _back.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"target.png"] ];
        return;
    }
    
    if ([_strback isEqualToString:@"weis"])
    {
       _back.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"weis.png"] ];
        return;
    }
    
    if ([_strback isEqualToString:@"walmart"])
    {
        _back.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"walmart.png"] ];
        return;
    }

    
    
   // _detail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wal.png"] ];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
