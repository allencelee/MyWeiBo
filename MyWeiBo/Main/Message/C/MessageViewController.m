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
static NSInteger i= 0;
@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 50);
    [button setTitle:@"更换主题" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(changeTheme) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


-(void)changeTheme{
    

    if (i==15) {
        i=0;
    }
    TheameManager *manager = [TheameManager sharedInstance];
    NSDictionary *dic = manager.dic;
    NSArray *arr = [dic allKeys];
    manager.theameName = arr[i];
    i++;
    

    [[NSNotificationCenter defaultCenter]postNotificationName:@"noti" object:self];
}




@end
