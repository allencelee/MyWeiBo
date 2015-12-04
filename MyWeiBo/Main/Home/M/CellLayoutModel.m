//
//  cellLayoutModel.m
//  MyWeiBo
//
//  Created by imac on 15/12/4.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "cellLayoutModel.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation CellLayoutModel

-(void)setWeiboModel:(WeiboModel *)weiboModel{

    _weiboModel = weiboModel;
    [self getCellHeight];
}

-(void)getCellHeight{

    NSDictionary *dic = @{
                          NSFontAttributeName:[UIFont systemFontOfSize:15],
                          NSForegroundColorAttributeName:[UIColor blackColor]
                          };
   CGRect frame = [_weiboModel.text boundingRectWithSize:CGSizeMake(kScreenWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    _textFrame = CGRectMake(10, 65, frame.size.width, frame.size.height);
    
    _cellHeight = 60+10+frame.size.height;
    
}
@end
