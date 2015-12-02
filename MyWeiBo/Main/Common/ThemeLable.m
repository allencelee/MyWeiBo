//
//  ThemeLable.m
//  MyWeiBo
//
//  Created by imac on 15/12/2.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ThemeLable.h"

@implementation ThemeLable

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadColorName) name:kThemeChange object:nil];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadColorName) name:kThemeChange object:nil];
    }
    return self;
}

-(void)setFontColor:(NSString *)fontColor{

    if (_fontColor != fontColor) {
        _fontColor = fontColor;
        [self loadColorName];
    }
}

-(void)loadColorName{

    TheameManager *manager = [TheameManager sharedInstance];
    UIColor *color = [manager getThemePathWithColor:_fontColor];
    self.textColor = color;
}

@end
