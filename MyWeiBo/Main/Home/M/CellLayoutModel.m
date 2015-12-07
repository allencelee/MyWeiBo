//
//  cellLayoutModel.m
//  MyWeiBo
//
//  Created by imac on 15/12/4.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "cellLayoutModel.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kMargin 10
#define kCellHeight 60
@implementation CellLayoutModel

-(void)setWeiboModel:(WeiboModel *)weiboModel{

    _weiboModel = weiboModel;
    [self getCellHeight];
}

-(void)getCellHeight{

    CGFloat cellHeight = kCellHeight;
    NSDictionary *dic = @{
                          NSFontAttributeName:[UIFont systemFontOfSize:15],
                          NSForegroundColorAttributeName:[UIColor blackColor]
                          };
   CGRect frame = [_weiboModel.text boundingRectWithSize:CGSizeMake(kScreenWidth-15, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    _textFrame = CGRectMake(10, 65, frame.size.width, frame.size.height);
    cellHeight = cellHeight+kMargin+frame.size.height;
    //---微博图片高度
    CGFloat imgX = CGRectGetMinX(self.textFrame);
    CGFloat imgY = CGRectGetMaxY(self.textFrame)+kMargin;
    CGFloat imgWidth = 0;
    CGFloat imgHeight = 0;
    //判断微博有没有图片
    if (self.weiboModel.thumbnail_pic) {
        
        imgWidth = 80;
        imgHeight =100;
    }
    
    self.weiboImageFrame = CGRectMake(imgX, imgY, imgWidth, imgHeight);
    
    cellHeight = cellHeight+self.weiboImageFrame.size.height+kMargin;
    
    //转发微博
    [self reweetWeibo];
    if (self.weiboModel.retweeted_status) {
        cellHeight = cellHeight+self.reweetBgimgFrame.size.height;
    }
    
    self.cellHeight = cellHeight;
    
}

-(void)reweetWeibo{

    if (self.weiboModel.retweeted_status) {
        
        CGFloat reweetBgimgX = CGRectGetMinX(self.textFrame);
        CGFloat reweetBgimgY = CGRectGetMaxY(self.textFrame)+5;
        CGFloat reweetBgimgWidth = kScreenWidth-kMargin*2;
        self.reweetBgimgFrame = CGRectMake(reweetBgimgX, reweetBgimgY, reweetBgimgWidth, 0);
        //计算转发文字frame
        NSDictionary *dic = @{
                              NSFontAttributeName:[UIFont systemFontOfSize:15],
                              NSForegroundColorAttributeName:[UIColor blackColor]
                              };

        CGRect frame = [self.weiboModel.retweeted_status.text boundingRectWithSize:CGSizeMake(kScreenWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        
        
        self.reweetTextFrame = CGRectMake(reweetBgimgX+5, reweetBgimgY+5, self.reweetBgimgFrame.size.width-kMargin, frame.size.height);
        self.reweetBgimgFrame = CGRectMake(reweetBgimgX, reweetBgimgY, reweetBgimgWidth, self.reweetTextFrame.size.height+kMargin);
    }
    
 }
@end
