//
//  MoreViewController.h
//  MyWeiBo
//
//  Created by imac on 15/12/1.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeViewController.h"
@interface MoreViewController : UITableViewController

@property (weak, nonatomic) IBOutlet ThemeImageView *row1Image;
@property (weak, nonatomic) IBOutlet ThemeImageView *row2Image;
@property (weak, nonatomic) IBOutlet ThemeImageView *row3Image;
@property (weak, nonatomic) IBOutlet ThemeLable *row1Lable;
@property (weak, nonatomic) IBOutlet ThemeLable *row2Lable;
@property (weak, nonatomic) IBOutlet ThemeLable *row3Lable;
@property (weak, nonatomic) IBOutlet ThemeLable *row4Lable;
@property (weak, nonatomic) IBOutlet ThemeLable *themeLable;





@end
