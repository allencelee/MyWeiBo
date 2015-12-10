//
//  RightViewController.m
//  MyWeiBo
//
//  Created by imac on 15/12/1.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()
@property (weak, nonatomic) IBOutlet ThemeButton *writeButton;
@property (weak, nonatomic) IBOutlet ThemeButton *cameraButton;
@property (weak, nonatomic) IBOutlet ThemeButton *photoButton;
@property (weak, nonatomic) IBOutlet ThemeButton *videoButton;


@end


@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _writeButton.imgName = @"newbar_icon_1.png";
    _cameraButton.imgName = @"newbar_icon_2.png";
    _photoButton.imgName = @"newbar_icon_3.png";
    _videoButton.imgName = @"newbar_icon_4.png";
    
}
- (IBAction)buttonAction:(UIButton *)sender {
    
    if (sender.tag == 101) {
    
        SendViewController *sendVC = [[SendViewController alloc]init];
        BaseNavigationController *baseNC = [[BaseNavigationController alloc]initWithRootViewController:sendVC];
        [self presentViewController:baseNC animated:YES completion:nil];
    }
}


@end
