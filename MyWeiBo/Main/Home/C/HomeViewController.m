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
#import <AudioToolbox/AudioToolbox.h>

@interface HomeViewController ()<SinaWeiboRequestDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SinaWeibo *sinaWibo = [self sinaweibo];
    
    NSArray *saveDataArr = (NSArray*)[[NSUserDefaults standardUserDefaults] objectForKey:@"saveData"];
    
    
    if (saveDataArr != nil) {
        
        _homeTableView.data = [saveDataArr mutableCopy];
    }
    
    if (sinaWibo.isAuthValid) {
        
        [self loadData];
    }else{
    
        [sinaWibo logIn];
    }
    __weak HomeViewController *weakSelf = self;
    self.homeTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf loadData];
    }];
    
    self.homeTableView.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [weakSelf loadOldData];
    }];
}

-(void)loadData{
    SinaWeibo *sinaWeibo = [self sinaweibo];

    long sinceId = 0;
    if (self.homeTableView.data > 0) {
        
        CellLayoutModel *layoutModel = self.homeTableView.data[0];
        sinceId = layoutModel.weiboModel.id;
    }
    NSDictionary *dic = @{@"since_id":[NSString stringWithFormat:@"%ld",sinceId]};
    
    [sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                       params:[dic mutableCopy]
                   httpMethod:@"GET"
                     delegate:self];
    
}

-(void)loadOldData{

    SinaWeibo *sinaWeibo = [self sinaweibo];
    long sinceId = 0;
    if (self.homeTableView.data > 0) {
        
        CellLayoutModel *layout = [_homeTableView.data lastObject];
        sinceId = layout.weiboModel.id;
        
    }
    NSDictionary *dic = @{@"max_id":[NSString stringWithFormat:@"%ld",sinceId]};
    [sinaWeibo requestWithURL:@"statuses/home_timeline.json" params:[dic mutableCopy] httpMethod:@"GET" delegate:self];
    
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
    
    NSArray *allKey = [request.params allKeys];
    NSString *key = [allKey firstObject];
    if ([key isEqualToString:@"since_id"]) {
        BaseTabBarViewController *tabbarC = (BaseTabBarViewController*)[self tabBarController];
        tabbarC.loadUnreadImgView.hidden = YES;
        
        [self showCount:data.count];
        [data addObjectsFromArray:_homeTableView.data];

        _homeTableView.data = data ;

        [_homeTableView reloadData];
    }else if ([key isEqualToString:@"max_id"]){
    
        CellLayoutModel *firstData = data[0];
        CellLayoutModel *lastData = [self.homeTableView.data lastObject];
        
        if (firstData.weiboModel.id == lastData.weiboModel.id) {
            
            [data removeObject:firstData];
        }
        [_homeTableView.data addObjectsFromArray:data];
    }
    
    
    [_homeTableView reloadData];
    

    
//    [[NSUserDefaults standardUserDefaults] setObject:[_homeTableView.data copy] forKey:@"saveData"];
    
    [_homeTableView.header endRefreshing];
    [_homeTableView.footer endRefreshing];

}

-(ThemeImageView*)showLoadImgView{

    if (_showLoadImgView == nil) {
        
        _showLoadImgView = [[ThemeImageView alloc]initWithFrame:CGRectMake(5, -40, kScreenWidth-10,40)];
        _showLoadImgView.imgName = @"timeline_notify.png";
        [self.view addSubview:_showLoadImgView];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:_showLoadImgView.bounds];
        lable.backgroundColor = [UIColor clearColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.tag = 1001;
        [_showLoadImgView addSubview:lable];
        
    }
    return _showLoadImgView;
}

-(void)showCount:(NSInteger)count{

    UILabel *lable = (UILabel*)[self.showLoadImgView viewWithTag:1001];
    NSString *str = [NSString stringWithFormat:@"%ld条新微博",count];
    lable.text  = str;
    
    [UIView animateWithDuration:2 animations:^{
        
        self.showLoadImgView.transform = CGAffineTransformMakeTranslation(0, 40);
    } completion:^(BOOL finished) {
        
        self.showLoadImgView.transform = CGAffineTransformIdentity;
    }];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"msgcome.wav" ofType:nil];
    SystemSoundID soundId = 0;
    NSURL *url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundId);
    AudioServicesPlaySystemSound(soundId);
    
    
}




@end
