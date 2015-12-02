//
//  TheameManager.m
//  MyWeiBo
//
//  Created by imac on 15/12/1.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "TheameManager.h"
static TheameManager *manager = nil;
@implementation TheameManager

+(id)sharedInstance{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[TheameManager alloc]init];
    });
    return manager;
}
-(instancetype)init{

    if (self = [super init]) {
        
//       _theameName = @"猫爷";
        NSString *theameName = [[NSUserDefaults standardUserDefaults] objectForKey:@"TheameName"];
        _theameName = theameName ? : @"猫爷";
    }
    
    

    return self;
}

-(void)setTheameName:(NSString *)theameName{

    if (_theameName != theameName) {
        _theameName = theameName;
        
        [[NSUserDefaults standardUserDefaults]setObject:_theameName forKey:@"TheameName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter]postNotificationName:kThemeChange object:self];
    }
}
//获取主题文件夹
-(NSString*)getTheamePath{
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"Theme.plist" ofType:nil];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSString *Path =  [dic objectForKey:_theameName];
    NSString *themePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:Path];
    return themePath;}
//获取主题图片
-(UIImage *)getTheameImage:(NSString *)imageName{

    NSString *path = [self getTheamePath];
    NSString *imagePath = [path stringByAppendingPathComponent:imageName ];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

-(UIColor*)getThemePathWithColor:(NSString *)colorName{

    NSString *path  = [self getTheamePath];
    NSString *plistPath = [path stringByAppendingPathComponent:@"config.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    NSDictionary *RGBDic = dic[colorName];
    CGFloat R = [RGBDic[@"R"] floatValue];
    CGFloat B = [RGBDic[@"B"]floatValue];
    CGFloat G = [RGBDic[@"G"]floatValue];
    CGFloat alpha = [RGBDic[@"alpha"]floatValue] ? : 1;

    UIColor *color = [UIColor colorWithRed:R/255 green:G/255 blue:B/255 alpha:alpha];
    return color;
}

@end
