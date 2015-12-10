//
//  CommentViewController.h
//  MyWeiBo
//
//  Created by imac on 15/12/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "MyTableViewCell.h"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "AppDelegate.h"
#import "CommentModel.h"
#import "CommentTableViewCell.h"
#import "WXLabel.h"
@interface CommentViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,SinaWeiboDelegate,SinaWeiboRequestDelegate,WXLabelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property(nonatomic,strong)CellLayoutModel *layout;
@property(nonatomic,strong)NSMutableArray *data;
//@property(nonatomic,strong)CommentTableViewCell *commentCell;
@end
