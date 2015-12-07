//
//  cellLayoutModel.h
//  MyWeiBo
//
//  Created by imac on 15/12/4.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModel.h"

@interface CellLayoutModel : NSObject
@property(nonatomic,strong)WeiboModel *weiboModel;
@property(nonatomic,assign)CGRect textFrame;
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,assign)CGRect weiboImageFrame;

@property(nonatomic,assign)CGRect reweetTextFrame;
@property(nonatomic,assign)CGRect reweetBgimgFrame;

@end
