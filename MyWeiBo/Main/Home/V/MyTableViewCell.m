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
