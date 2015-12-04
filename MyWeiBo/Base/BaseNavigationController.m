//
//  BaseNavigationController.m
//  MyWeiBo
//
//  Created by imac on 15/12/1.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadImage];
    self.navigationBar.translucent = NO;
}

-(id)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImage) name:kThemeChange object:nil];
    }
    return self;
}


-(void)loadImage{
    
    TheameManager *manager = [TheameManager sharedInstance];
    UIImage *img = [manager getTheameImage:@"mask_titlebar64@2x.png"];
    [self.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
