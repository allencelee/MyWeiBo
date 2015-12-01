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
        
       _theameName = @"猫爷";
    }
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"Theme.plist" ofType:nil];
    _dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return self;
}
//获取主题文件夹
-(NSString*)getTheamePath{

    NSString *path = [_dic objectForKey:_theameName];

    NSString *theamePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:path];
    return theamePath;
}
//获取主题图片

-(UIImage *)getTheameImage:(NSString *)imageName{

    NSString *path = [self getTheamePath];
    
    NSString *imagePath = [path stringByAppendingPathComponent:imageName ];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

@end
