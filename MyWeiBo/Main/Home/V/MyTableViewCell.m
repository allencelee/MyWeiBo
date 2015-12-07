//
//  MyTableViewCell.m
//  MyWeiBo
//
//  Created by imac on 15/12/4.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (void)awakeFromNib {

    _userName.fontColor = @"Timeline_Name_color";
    _creatTime.fontColor = @"Timeline_Name_color";
    _source.fontColor = @"Timeline_Name_color";
    
    _weiboTextLable  = [[UILabel alloc]init];
    
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
    //    _creatTime.text = model.created_at;
    _creatTime.text = [UIUtils fomateString:_layoutModel.weiboModel.created_at];
    //    _source.text = model.source;
    _source.text = [self getSourceString:_layoutModel.weiboModel.source];
    
    _weiboTextLable.frame = _layoutModel.textFrame;
    _weiboTextLable.text = _layoutModel.weiboModel.text;
    _weiboTextLable.numberOfLines = 0;
    
    //设置imgView的frame
    self.weiboImageView.frame= self.layoutModel.weiboImageFrame;
    [_weiboImageView sd_setImageWithURL:[NSURL URLWithString:_layoutModel.weiboModel.thumbnail_pic]];
    //--转发

    UIImage *img = [[TheameManager sharedInstance]getTheameImage:@"timeline_rt_border_9.png"];
    img = [img stretchableImageWithLeftCapWidth:30 topCapHeight:20];
    self.reweetBgimagView.image = img;
    self.reweetBgimagView.frame = _layoutModel.reweetBgimgFrame;
    self.reweetTextLable.frame = _layoutModel.reweetTextFrame;
    self.reweetTextLable.text = _layoutModel.weiboModel.retweeted_status.text;
    
    
}

-(ThemeLable*)reweetTextLable{

    if (_reweetTextLable == nil) {
        _reweetTextLable = [[ThemeLable alloc]init];
        _reweetTextLable.numberOfLines = 0;
        _reweetTextLable.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_reweetTextLable];
        
    }
    return _reweetTextLable;
}

-(UIImageView*)reweetBgimagView{

    if (_reweetBgimagView == nil) {
        _reweetBgimagView = [[ThemeImageView alloc]init];
        [self.contentView addSubview:_reweetBgimagView];
    }
    return _reweetBgimagView;
}

-(UIImageView*)weiboImageView{

    if (_weiboImageView == nil) {
        _weiboImageView = [[UIImageView alloc]init];
    }
    [self.contentView addSubview:_weiboImageView];
    return  _weiboImageView;
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
@end
