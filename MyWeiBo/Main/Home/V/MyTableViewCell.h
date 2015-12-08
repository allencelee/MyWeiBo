//
//  MyTableViewCell.h
//  MyWeiBo
//
//  Created by imac on 15/12/4.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "WeiboModel.h"
#import "ThemeLable.h"
#import "UIUtils.h"
#import "CellLayoutModel.h"
#import "WXLabel.h"
@interface MyTableViewCell : UITableViewCell<WXLabelDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet ThemeLable *userName;
@property (weak, nonatomic) IBOutlet ThemeLable *creatTime;
@property (weak, nonatomic) IBOutlet ThemeLable *source;
//@property(nonatomic,strong)WeiboModel *model;
@property(nonatomic,strong)CellLayoutModel *layoutModel;
@property(nonatomic,strong)WXLabel *weiboTextLable;
@property(nonatomic,strong)UIImageView *weiboImageView;

@property(nonatomic,strong)ThemeImageView *reweetBgimagView;
@property(nonatomic,strong)WXLabel *reweetTextLable;

@property(nonatomic,strong)UIImageView *reweetImgView;
@property(nonatomic,strong)NSMutableArray *imgViewArr;
@property(nonatomic,strong)NSMutableArray *reweetImgViewArr;
@end
