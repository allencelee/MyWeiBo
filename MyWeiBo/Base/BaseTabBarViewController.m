//
//  BaseTabBarViewController.m
//  MyWeiBo
//
//  Created by imac on 15/12/1.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseTabBarViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@interface BaseTabBarViewController ()
@end
@implementation BaseTabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubC];
    [self creatTabbar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(creatTabbar) name:@"noti" object:nil];

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self removeItem];
}

-(void)creatSubC{
    
    UIStoryboard *homeS = [UIStoryboard storyboardWithName:@"HomeStoryboard" bundle:nil];
    UIStoryboard *messageS = [UIStoryboard storyboardWithName:@"MessageStoryboard" bundle:nil];
    UIStoryboard *discoverS = [UIStoryboard storyboardWithName:@"DiscoverStoryboard" bundle:nil];
    UIStoryboard *profileS = [UIStoryboard storyboardWithName:@"ProfileStoryboard" bundle:nil];
    UIStoryboard *moreS = [UIStoryboard storyboardWithName:@"MoreStoryboard" bundle:nil];
    
    NSArray *viewC = @[
                       [homeS instantiateInitialViewController],
                    [messageS instantiateInitialViewController],
                       [discoverS instantiateInitialViewController],
                       [profileS instantiateInitialViewController],
                       [moreS instantiateInitialViewController]
                       ];
    self.viewControllers = viewC;
}

-(void)creatTabbar{

    for (UIView *view in self.tabBar.subviews) {
        
        [view removeFromSuperview];
    }
    NSLog(@"换主题");
    UIImageView *background = [[UIImageView alloc]initWithFrame:CGRectMake(0, -6, kScreenWidth, 55)];
    
//    background.image = [UIImage imageNamed:@"mask_navbar"];
    TheameManager *manager = [TheameManager sharedInstance];
    background.image = [manager getTheameImage:@"mask_navbar"];
    [self.tabBar addSubview:background];
    
    CGFloat itemWidth = kScreenWidth/5;
    NSArray *imageArr = @[
                          @"home_tab_icon_1.png",
                          @"home_tab_icon_2.png",
                          @"home_tab_icon_3.png",
                          @"home_tab_icon_4.png",
                          @"home_tab_icon_5.png",
                          ];
    
    for (int i=0; i<imageArr.count; i++) {
        
        UIButton *tabbarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tabbarButton.frame = CGRectMake(i*itemWidth, 2, itemWidth, 45);
        tabbarButton.tag = 1000+i;
        NSString *imageName = imageArr[i];
        
        //UIImage *buttonImg = [UIImage imageNamed:imageName];
        UIImage *buttonImg = [manager getTheameImage:imageName];
        [tabbarButton setImage:buttonImg forState:UIControlStateNormal];
        [tabbarButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:tabbarButton];
        
    }
    _selectImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, itemWidth, 45)];
//    _selectImg.image = [UIImage imageNamed:@"home_bottom_tab_arrow.png"];
    _selectImg.image = [manager getTheameImage:@"home_bottom_tab_arrow.png"];

    [self.tabBar addSubview:_selectImg];
}

-(void)buttonAction:(UIButton*)button{

    self.selectedIndex = button.tag-1000;
    
    _selectImg.center = button.center;
    
}



-(void)removeItem{

    for (UIView *view in self.tabBar.subviews) {
        
        if ([view isKindOfClass:NSClassFromString(@"UITabBarItem")]) {
            
            [view removeFromSuperview];
        }
    }
}


-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
