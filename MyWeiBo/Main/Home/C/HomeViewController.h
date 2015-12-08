//
//  HomeViewController.h
//  MyWeiBo
//
//  Created by imac on 15/12/1.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboModel.h"
#import "MyTableView.h"
#import "MJRefresh.h"
#import "BaseTabBarViewController.h"
@interface HomeViewController : BaseViewController

@property (weak, nonatomic) IBOutlet MyTableView *homeTableView;
@property(nonatomic,strong)ThemeImageView *showLoadImgView;

@end
