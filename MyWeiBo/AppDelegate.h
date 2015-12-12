//
//  AppDelegate.h
//  MyWeiBo
//
//  Created by imac on 15/12/1.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,SinaWeiboDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)MMDrawerController *drawController;
@property(nonatomic,strong)SinaWeibo *sinaWeibo;
@end

