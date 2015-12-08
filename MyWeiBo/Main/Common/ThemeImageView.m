//
//  TabbarBackgroundImg.m
//  MyWeiBo
//
//  Created by imac on 15/12/2.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ThemeImageView.h"

@implementation ThemeImageView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImg) name:kThemeChange object:nil];
    }
    return self;
}

-(void)setImgName:(NSString *)imgName{

        _imgName = imgName;
        [self loadImg];
    
}

-(void)loadImg{

    UIImage *img = [[TheameManager sharedInstance] getTheameImage:_imgName];
    
    self.image = [img resizableImageWithCapInsets:self.edgeInsets resizingMode:UIImageResizingModeStretch];
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
