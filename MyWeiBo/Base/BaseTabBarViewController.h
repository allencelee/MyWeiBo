//
//  BaseTabBarViewController.h
//  MyWeiBo
//
//  Created by imac on 15/12/1.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface BaseTabBarViewController : UITabBarController<SinaWeiboRequestDelegate>

@property(nonatomic,strong)ThemeImageView *selectImg;
@property(nonatomic,strong)ThemeImageView *loadUnreadImgView;
-(void)creatTabbar;
@end
