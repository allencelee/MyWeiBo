//
//  MyTableView.m
//  MyWeiBo
//
//  Created by imac on 15/12/4.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MyTableView.h"

static NSString *identifier = @"MyTableViewCell";
@implementation MyTableView

-(void)awakeFromNib{

    [self setConfig];
}

-(void)setConfig{

    self.delegate = self;
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _data.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.layoutModel = _data[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CellLayoutModel *layout = _data[indexPath.row];

    return layout.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CellLayoutModel *model = _data[indexPath.row];
    
    CommentViewController *commentViewC = [[CommentViewController alloc]init];
    commentViewC.layout = model;
    
    BaseViewController *viewController = (BaseViewController*)self.superview.nextResponder;
    [viewController.navigationController pushViewController:commentViewC animated:YES];
}

@end
