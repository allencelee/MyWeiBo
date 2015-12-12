//
//  FaceView.h
//  MyWeiBo
//
//  Created by imac on 15/12/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewExt.h"
#import "UIViewExt.h"
#define imgWidth 30
#define imgHeight 30
#define itemWidth (kScreenWidth/7)
#define itemHeight (kScreenWidth/7)

@interface FaceView : UIView
@property(nonatomic,strong)NSMutableArray *items;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,copy)NSString *selectedName;
@end
