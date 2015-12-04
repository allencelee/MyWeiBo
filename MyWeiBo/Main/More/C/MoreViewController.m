//
//  MoreViewController.m
//  MyWeiBo
//
//  Created by imac on 15/12/1.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadName];
    [self loadImage];
    TheameManager *manager = [TheameManager sharedInstance];
    _themeLable.text = manager.theameName;
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImage) name:kThemeChange object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeThemeLable) name:@"tName" object:nil];
 

      
    }
    return self;
}
-(void)loadImage{

    TheameManager *manager = [TheameManager sharedInstance];
    self.view.backgroundColor = [manager getThemePathWithColor:@"More_Item_Line_color"];
}

-(void)changeThemeLable{
    
    TheameManager *manager = [TheameManager sharedInstance];
    _themeLable.text = manager.theameName;
}

-(void)loadName{

    _row1Lable.fontColor = @"More_Item_Text_color";
    _row2Lable.fontColor = @"More_Item_Text_color";
    _row3Lable.fontColor = @"More_Item_Text_color";
    _row4Lable.fontColor = @"More_Item_Text_color";
    
    _row1Image.imgName = @"more_icon_theme@2x.png";
    _row2Image.imgName = @"more_icon_account@2x.png";
    _row3Image.imgName = @"more_icon_feedback@2x.png";

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0&& indexPath.section ==0) {
        ThemeViewController *theme = [[ThemeViewController alloc]init];
        theme.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:theme animated:YES];
    }
    
}


@end
