//
//  ThemeViewController.m
//  MyWeiBo
//
//  Created by imac on 15/12/2.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ThemeViewController.h"

@interface ThemeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _themeTableView.delegate = self;
    _themeTableView.dataSource = self;
    [self loadData];

    TheameManager *manager = [TheameManager sharedInstance];
    UIImage *image = [manager getTheameImage:@"mask_timeline_ref_top"];
    _themeTableView.separatorColor = [UIColor colorWithPatternImage:image];


}

-(void)loadData{

    NSString *path = [[NSBundle mainBundle]pathForResource:@"Theme.plist" ofType:nil];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    _data = [dic allKeys];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _data.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    TheameManager *manager = [TheameManager sharedInstance];
    manager.theameName = _data[indexPath.row];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"tName" object:nil];
}
@end
