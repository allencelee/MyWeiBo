//
//  ThemeViewController.h
//  MyWeiBo
//
//  Created by imac on 15/12/2.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeViewController : UIViewController
@property(nonatomic,strong)NSArray *data;
@property (weak, nonatomic) IBOutlet UITableView *themeTableView;


@end
