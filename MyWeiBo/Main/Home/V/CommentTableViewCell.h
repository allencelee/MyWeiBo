//
//  CommentTableViewCell.h
//  MyWeiBo
//
//  Created by imac on 15/12/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeLable.h"
#import "CommentModel.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"
#import "WXLabel.h"
@interface CommentTableViewCell : UITableViewCell<WXLabelDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
@property (weak, nonatomic) IBOutlet ThemeLable *userName;
@property (weak, nonatomic) IBOutlet ThemeLable *creatTime;

@property(nonatomic,strong)CommentModel *commentModel;
@property(nonatomic,strong)WXLabel *textLable;

@end
