//
//  MessageViewController.m
//  MyWeiBo
//
//  Created by imac on 15/12/1.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MessageViewController.h"
#import "TheameManager.h"
#import "BaseTabBarViewController.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    ThemeLable *lable = [[ThemeLable alloc]initWithFrame:(CGRect){100,100,100,50}];
    lable.text = @"MLGB";
    lable.fontColor = @"Msg_Name_color";
    [self.view addSubview:lable];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    static BOOL falg = YES;
    
    TheameManager *ma = [TheameManager sharedInstance];
    
    ma.theameName = falg ? @"猫爷" : @"蓝月亮";
    
    falg = !falg;
    
    
    
}




@end
