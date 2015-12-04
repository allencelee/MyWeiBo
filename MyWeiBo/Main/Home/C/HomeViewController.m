//
//  HomeViewController.m
//  MyWeiBo
//
//  Created by imac on 15/12/1.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "cellLayoutModel.h"
@interface HomeViewController ()<SinaWeiboRequestDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SinaWeibo *sinaWibo = [self sinaweibo];
    
    if (sinaWibo.isAuthValid) {
        
        [sinaWibo requestWithURL:@"statuses/home_timeline.json" params:nil httpMethod:@"GET" delegate:self];
    }else{
    
        [sinaWibo logIn];
    }
    
}

-(SinaWeibo*)sinaweibo{

    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return  delegate.sinaWeibo;
}

#pragma mark - sinaWeiboReqyestDelegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error;{

    NSLog(@"请求失败");
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{

    NSMutableArray *data = [NSMutableArray array];

    NSLog(@"请求成功");
    NSArray *weiboArr = result[@"statuses"];
    for (NSDictionary *dic in weiboArr) {
        CellLayoutModel *layout = [[CellLayoutModel alloc]init];
        WeiboModel *weiboMdel = [[WeiboModel alloc]initWithDictionary:dic error:nil];
        layout.weiboModel = weiboMdel;
        [data addObject:layout];
    }
    _homeTableView.data = [data copy];
    [_homeTableView reloadData];

}


@end
