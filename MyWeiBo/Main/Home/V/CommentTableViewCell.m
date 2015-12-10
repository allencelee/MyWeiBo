//
//  CommentTableViewCell.m
//  MyWeiBo
//
//  Created by imac on 15/12/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {

    _userName.fontColor = @"Timeline_Name_color";
    _creatTime.fontColor = @"Timeline_Name_color";
    

}

-(void)setCommentModel:(CommentModel *)commentModel{

    _commentModel = commentModel;

    [self setNeedsDisplay];
}

-(void)layoutSubviews{

    [super layoutSubviews];
    NSString *userStr = [NSString stringWithString:_commentModel.user[@"profile_image_url"]] ;
    NSURL *url = [NSURL URLWithString:userStr];
    [_userImgView sd_setImageWithURL:url];
    _userName.text = _commentModel.user[@"screen_name"];
    
    NSString *timeStr = [UIUtils fomateString:_commentModel.created_at ];
    _creatTime.text =timeStr ;
    
    
//    CGRect textframe = [_commentModel.text boundingRectWithSize:CGSizeMake(kScreenWidth-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat textHeight = [WXLabel getTextHeight:16 width:kScreenWidth-20 text:_commentModel.text linespace:0];
    

    
    self.textLable.frame = CGRectMake(10, 65, kScreenWidth-20, textHeight);
    self.textLable.text = _commentModel.text;
    
}

-(WXLabel*)textLable{

    if (_textLable == nil) {
        _textLable = [[WXLabel alloc]init];
        _textLable.wxLabelDelegate = self;
        _textLable.numberOfLines = 0;
        _textLable.font = [UIFont systemFontOfSize:16];
//        _textLable.textHeight=16;
        
        [self.contentView addSubview:_textLable];
    }
    return _textLable;
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
