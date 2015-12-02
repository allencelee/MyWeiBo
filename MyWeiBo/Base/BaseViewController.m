//
//  BaseViewController.m
//  MyWeiBo
//
//  Created by imac on 15/12/1.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
-(id)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImage) name:kThemeChange object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImage];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadImage{
    
    TheameManager *manager = [TheameManager sharedInstance];
    UIImage *img = [manager getTheameImage:@"bg_home@2x.jpg"];
    
    UIImage *newImage = [self getNewImage:img];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
//图片拉伸
//-(UIImage*)imageResize:(UIImage*)image withSizeTo:(CGSize)newSize{
//
//    CGFloat scale = [[UIScreen mainScreen]scale];
//    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
//    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
////    UIGraphicsEndImageContext();
//    return newImage;
//}

-(UIImage*)getNewImage:(UIImage*)img{

    UIGraphicsBeginImageContext(self.view.frame.size);
    [img drawInRect:self.view.frame];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



@end
