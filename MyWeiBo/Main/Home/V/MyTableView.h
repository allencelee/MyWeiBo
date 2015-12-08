//
//  MyTableView.h
//  MyWeiBo
//
//  Created by imac on 15/12/4.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableViewCell.h"
#import "CellLayoutModel.h"
@interface MyTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *data;
@end
