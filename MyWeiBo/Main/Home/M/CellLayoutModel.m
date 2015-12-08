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
#define kMoreImageSpace 5
@implementation CellLayoutModel
-(instancetype)init{

    if (self = [super init]) {
        
        _imgFrameArray = [[NSMutableArray alloc]init];
        _reweetImgFrameArray = [[NSMutableArray alloc]init];
        for (int i = 0; i<9; i++) {
            
            [_imgFrameArray addObject:[NSValue valueWithCGRect:CGRectZero]];
            [_reweetImgFrameArray addObject:[NSValue valueWithCGRect:CGRectZero]];
        }
    }
    return self;
}

-(void)setWeiboModel:(WeiboModel *)weiboModel{

    _weiboModel = weiboModel;
    [self getCellHeight];
}

-(void)getCellHeight{

    CGFloat cellHeight = kCellHeight;
    NSDictionary *dic = @{
                          NSFontAttributeName:[UIFont systemFontOfSize:15.0],
                          NSForegroundColorAttributeName:[UIColor blackColor]
                          };
   CGRect frame = [_weiboModel.text boundingRectWithSize:CGSizeMake(kScreenWidth-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    CGFloat textHeight = [WXLabel getTextHeight:15.0 width:kScreenWidth text:self.weiboModel.text linespace:0];
    
    self.textFrame = CGRectMake(kMargin, kCellHeight+5, frame.size.width, textHeight);
    cellHeight = cellHeight+kMargin+textHeight;
    
    //---带图片的cell高度
    
    CGFloat imgSize = (kScreenWidth-2*kMargin - 2*kMoreImageSpace)/3;
    for (int i = 0; i<self.weiboModel.pic_urls.count; i++) {
        
        int row = i/3;
        int column = i%3;
        CGFloat imgX = CGRectGetMinX(self.textFrame);
        CGFloat imgY = CGRectGetMaxY(self.textFrame)+kMargin;
        
        CGRect imgFrame = CGRectMake((imgX + column*(imgSize+kMoreImageSpace)), (imgY + row*(imgSize+kMoreImageSpace)), imgSize, imgSize);
        [self.imgFrameArray replaceObjectAtIndex:i withObject:[NSValue valueWithCGRect:imgFrame]];
    }
    NSInteger line = (self.weiboModel.pic_urls.count+2)/3;
    cellHeight += line*imgSize + kMoreImageSpace*(MAX(0, line-1)) + kMargin*(MAX(0, MIN(line, 1)));
    cellHeight = [self reweetWeibo:cellHeight];
    cellHeight = [self reweetImg:cellHeight];
    
    self.cellHeight = cellHeight;
    
}

-(CGFloat)reweetWeibo:(CGFloat)cellHeight{

    if (self.weiboModel.retweeted_status) {
        
        CGFloat reweetBgimgX = CGRectGetMinX(self.textFrame);
        CGFloat reweetBgimgY = CGRectGetMaxY(self.textFrame)+5;
        CGFloat reweetBgimgWidth = kScreenWidth-kMargin*2;
        self.reweetBgimgFrame = CGRectMake(reweetBgimgX, reweetBgimgY, reweetBgimgWidth, 0);
        
        CGFloat reweetTextX = CGRectGetMinX (self.reweetBgimgFrame )+kMargin;
        CGFloat reweetTextY = CGRectGetMinY(self.reweetBgimgFrame)+kMargin;
        CGFloat reweetTextWidth = CGRectGetWidth(self.reweetBgimgFrame)-kMargin*2;
        
        
        //计算转发文字frame
//        NSDictionary *dic = @{
//                              NSFontAttributeName:[UIFont systemFontOfSize:15.0],
//                              NSForegroundColorAttributeName:[UIColor blackColor]
//                              };

//        CGRect frame = [self.weiboModel.retweeted_status.text boundingRectWithSize:CGSizeMake(kScreenWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
       
        
        CGFloat textHeight = [WXLabel getTextHeight:15.0 width:kScreenWidth text:self.weiboModel.text linespace:0];
        
        self.reweetTextFrame = CGRectMake(reweetTextX, reweetTextY, reweetTextWidth, textHeight);
        self.reweetBgimgFrame = CGRectMake(reweetBgimgX, reweetBgimgY, reweetBgimgWidth, self.reweetTextFrame.size.height+kMargin*2);
        cellHeight = cellHeight + self.reweetBgimgFrame.size.height;
        return cellHeight;
    }
    
    return cellHeight;
    
 }

-(CGFloat)reweetImg:(CGFloat)cellHeight{

    if (self.weiboModel.retweeted_status.thumbnail_pic) {
        CGFloat imgSize = (self.reweetBgimgFrame.size.width-2*kMargin - 2*kMoreImageSpace)/3;
        for (int i = 0; i<self.weiboModel.retweeted_status.pic_urls.count; i++) {
            
            int row = i/3;
            int column = i%3;
            CGFloat imgX = CGRectGetMinX(self.reweetTextFrame);
            CGFloat imgY = CGRectGetMaxY(self.reweetTextFrame)+kMargin;
            
            CGRect imgFrame = CGRectMake((imgX + column*(imgSize+kMoreImageSpace)), (imgY + row*(imgSize+kMoreImageSpace)), imgSize, imgSize);
            [self.reweetImgFrameArray replaceObjectAtIndex:i withObject:[NSValue valueWithCGRect:imgFrame]];
        }
        NSInteger line = (self.weiboModel.retweeted_status.pic_urls.count+2)/3;

        CGFloat imgHeight = line*imgSize + kMoreImageSpace*(MAX(0, line-1)) + kMargin*(MAX(0, MIN(line, 1)));
        CGRect reweetBgImgFrame = self.reweetBgimgFrame;
        reweetBgImgFrame.size.height = self.reweetBgimgFrame.size.height + imgHeight;
        
        self.reweetBgimgFrame = reweetBgImgFrame;
        cellHeight = cellHeight + imgHeight;
        return cellHeight;
    }
    return cellHeight;
}
@end
