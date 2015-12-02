//
//  ThemeButton.m
//  MyWeiBo
//
//  Created by imac on 15/12/2.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ThemeButton.h"

@implementation ThemeButton

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImage) name:kThemeChange object:nil];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImage) name:kThemeChange object:nil];
    }
    return self;
}


-(void)setImgName:(NSString *)imgName{

    _imgName = imgName;
    [self loadImage];

}

-(void)loadImage{

    TheameManager *manager = [TheameManager sharedInstance];
    UIImage *img = [manager getTheameImage:_imgName];
    [self setImage:img forState:UIControlStateNormal];
}
@end
