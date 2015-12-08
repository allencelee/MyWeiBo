//
//  MyTableViewCell.m
//  MyWeiBo
//
//  Created by imac on 15/12/4.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MyTableViewCell.h"
#import "WXLabel.h"
@implementation MyTableViewCell

- (void)awakeFromNib {

    _userName.fontColor = @"Timeline_Name_color";
    _creatTime.fontColor = @"Timeline_Name_color";
    _source.fontColor = @"Timeline_Name_color";
    
    _weiboTextLable  = [[WXLabel alloc]init];
    _weiboTextLable.wxLabelDelegate = self;
    _weiboTextLable.numberOfLines = 0;
    _weiboTextLable.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_weiboTextLable];
}

-(void)setLayoutModel:(CellLayoutModel *)layoutModel{

    _layoutModel = layoutModel;
    [self setNeedsLayout];
}
-(void)layoutSubviews{

    [super layoutSubviews];
    NSURL *url = [NSURL URLWithString: _layoutModel.weiboModel.user.profile_image_url];
    [_userImage sd_setImageWithURL:url];
    _userName.text = _layoutModel.weiboModel.user.screen_name;
    _creatTime.text = [UIUtils fomateString:_layoutModel.weiboModel.created_at];
    _source.text = [self getSourceString:_layoutModel.weiboModel.source];
    
    _weiboTextLable.frame = _layoutModel.textFrame;
    _weiboTextLable.text = _layoutModel.weiboModel.text;
    
    //设置imgView的frame
    self.weiboImageView.frame= self.layoutModel.weiboImageFrame;
    [_weiboImageView sd_setImageWithURL:[NSURL URLWithString:_layoutModel.weiboModel.thumbnail_pic]];
    //--转发

//    UIImage *img = [[TheameManager sharedInstance]getTheameImage:@"timeline_rt_border_9.png"];
//    img = [img stretchableImageWithLeftCapWidth:30 topCapHeight:20];
//    

    self.reweetBgimagView.edgeInsets = UIEdgeInsetsMake(26, 25, 24, 25);
    self.reweetBgimagView.imgName = @"timeline_rt_border_9.png";
//    self.reweetBgimagView.image = img;
    self.reweetBgimagView.frame = _layoutModel.reweetBgimgFrame;
    self.reweetTextLable.frame = _layoutModel.reweetTextFrame;
    self.reweetTextLable.text = _layoutModel.weiboModel.retweeted_status.text;
    NSLog(@"%@",_weiboTextLable.text);

    //reweetImgView 赋值
//    self.reweetImgView.frame = _layoutModel.reweetImgFrame;
//    [self.reweetImgView sd_setImageWithURL:[NSURL URLWithString:self.layoutModel.weiboModel.retweeted_status.thumbnail_pic]];
    
    for (int i = 0; i<self.layoutModel.weiboModel.pic_urls.count; i++) {
        
        UIImageView *imgView = self.imgViewArr[i];
        NSString *imgUrlStr = self.layoutModel.weiboModel.pic_urls[i][@"thumbnail_pic"];
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrlStr]];
    }
    for (int i = 0; i<self.imgViewArr.count; i++) {
        
        UIImageView *imgView = self.imgViewArr[i];
        imgView.frame = [self.layoutModel.imgFrameArray[i] CGRectValue];
    }
    //微博多图赋值
    for (int i = 0; i<self.layoutModel.weiboModel.retweeted_status.pic_urls.count; i++) {
        UIImageView *reweetImgView = self.reweetImgViewArr[i];
        NSString *str = self.layoutModel.weiboModel.retweeted_status.pic_urls[i][@"thumbnail_pic"];
        [reweetImgView sd_setImageWithURL:[NSURL URLWithString:str]];
    }
    for (int i = 0; i<self.reweetImgViewArr.count; i++) {
        
        UIImageView *reweetImgView = self.reweetImgViewArr[i];
        reweetImgView.frame = [self.layoutModel.reweetImgFrameArray[i] CGRectValue];
    }
    
    
}


-(NSString*)getSourceString:(NSString *)source{

    NSInteger start = [source rangeOfString:@">"].location;
    NSInteger end = [source rangeOfString:@"<" options:NSBackwardsSearch].location;
    NSRange range = NSMakeRange(start+1, end-start-1);
    
    if (start != NSNotFound && end != NSNotFound) {
        NSString *str = [NSString stringWithFormat:@"来自  %@",[source substringWithRange:range]];
        return str;
    }else{
    
        return source;
    }

}

-(UIImageView*)reweetBgimagView{
    if (_reweetBgimagView == nil) {
        _reweetBgimagView = [[ThemeImageView alloc]init];
        //        [self.contentView insertSubview:_reweetImgView atIndex:0];
        [self.contentView addSubview:_reweetBgimagView];
    }
    return _reweetBgimagView;
}


-(UILabel*)reweetTextLable{
    
    if (_reweetTextLable == nil) {
        _reweetTextLable = [[WXLabel alloc]init];
        _reweetTextLable.wxLabelDelegate = self;
        _reweetTextLable.numberOfLines = 0;
        _reweetTextLable.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_reweetTextLable];
        
    }
    return _reweetTextLable;
}

-(NSMutableArray *)imgViewArr{
    
    if (!_imgViewArr) {
        
        _imgViewArr = [[NSMutableArray alloc]init];
        for (int i=0; i < 9; i++) {
            UIImageView *imgView = [[UIImageView alloc]init];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            [self.contentView addSubview:imgView];
            [_imgViewArr addObject:imgView];
        }
    }
    return _imgViewArr;
}


-(NSMutableArray *)reweetImgViewArr{
    
    if (!_reweetImgViewArr) {
        _reweetImgViewArr = [[NSMutableArray alloc]init];
        for (int i=0; i < 9; i++) {
            UIImageView *imgView = [[UIImageView alloc]init];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            [self.contentView addSubview:imgView];
            [_reweetImgViewArr addObject:imgView];
        }
        
    }
    return _reweetImgViewArr;
    
}

#pragma mark - WXLAbleDelegat

- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel{

    NSString *str1 = @"http(s)?://([a-zA-Z0-9_.-]+(/)?)*";
    NSString *str2 = @"@[\\w.-]{2,30}";
    NSString *str3 = @"#[^#]+#";
    
    NSString *str = [NSString stringWithFormat:@"%@|%@|%@",str1,str2,str3];
    return str;
}

//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel{

    return [UIColor blueColor];
}

-(void)toucheBenginWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context{

    NSLog(@"%@",context);
}

-(NSString*)imagesOfRegexStringWithWXLabel:(WXLabel *)wxLabel{

   return @"\\[\\w+\\]";
}
@end
