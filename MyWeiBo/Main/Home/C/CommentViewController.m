//
//  CommentViewController.m
//  MyWeiBo
//
//  Created by imac on 15/12/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end
static NSString *identify = @"CommentTableViewCell";
@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    [self loadCommentData];
    _data = [[NSMutableArray alloc]init];
}

-(instancetype)init{

    if (self = [super init]) {
        
       
    }
    return self;
}

-(void)loadCommentData{

    SinaWeibo *sinaWeibo = [self sinaWeibo];
    sinaWeibo.delegate = self;
    long commentId = _layout.weiboModel.id;
    NSString *strId = [NSString stringWithFormat:@"%ld",commentId];
    NSDictionary *dic = @{@"id":strId};
    [sinaWeibo requestWithURL:@"comments/show.json" params:[dic mutableCopy] httpMethod:@"GET" delegate:self];
    
    
}

-(SinaWeibo*)sinaWeibo{

    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = delegate.sinaWeibo;
    return sinaWeibo;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _data.count+1;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        MyTableViewCell *cell = [[[NSBundle mainBundle ]loadNibNamed:@"MyTableViewCell" owner:self options:nil]lastObject];
        cell.layoutModel = _layout;
        return cell;
    }else{
    
        CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
        cell.commentModel = _data[indexPath.row-1];
        return cell;
        
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        
        CGFloat height = self.layout.cellHeight;
        return height;
    }
    
    CommentModel *model = _data[indexPath.row-1];
    
    CGFloat textHeight = [WXLabel getTextHeight:16 width:kScreenWidth-20 text:model.text linespace:0];
    return textHeight + 60 +10 ;
}

-(void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{


    NSArray *commentArr = result[@"comments"];
    for (NSDictionary *dic in commentArr) {
        
        CommentModel *commentModel = [[CommentModel alloc]initWithDictionary:dic error:nil];
        [_data addObject:commentModel];

                
        NSLog(@"%@",commentModel.text);
        
    }
    [self.myTableView reloadData];

//    NSString *text = dic[@"text"];
//    NSDictionary *userDic = dic[@"user"];
    
    
    NSLog(@"评论请求成功");

    
}


/*
 {
     "comments": [
         {
             "created_at": "Wed Jun 01 00:50:25 +0800 2011",
             "id": 12438492184,
             "text": "love your work.......",
             "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
             "mid": "202110601896455629",
             "user": {
                 "id": 1404376560,
                 "screen_name": "zaku",
                 "name": "zaku",
                 "province": "11",
                 "city": "5",
                 "location": "北京 朝阳区",
                 "description": "人生五十年，乃如梦如幻；有生斯有死，壮士复何憾。",
                 "url": "http://blog.sina.com.cn/zaku",
                 "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
                 "domain": "zaku",
                 "gender": "m",
                 "followers_count": 1204,
                 "friends_count": 447,
                 "statuses_count": 2908,
                 "favourites_count": 0,
                 "created_at": "Fri Aug 28 00:00:00 +0800 2009",
                 "following": false,
                 "allow_all_act_msg": false,
                 "remark": "",
                 "geo_enabled": true,
                 "verified": false,
                 "allow_all_comment": true,
                 "avatar_large": "http://tp1.sinaimg.cn/1404376560/180/0/1",
                 "verified_reason": "",
                 "follow_me": false,
                 "online_status": 0,
                 "bi_followers_count": 215
             },
             "status": {
                 "created_at": "Tue May 31 17:46:55 +0800 2011",
                 "id": 11488058246,
                 "text": "求关注。"，
                 "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
                 "favorited": false,
                 "truncated": false,
                 "in_reply_to_status_id": "",
                 "in_reply_to_user_id": "",
                 "in_reply_to_screen_name": "",
                 "geo": null,
                 "mid": "5612814510546515491",
                 "reposts_count": 8,
                 "comments_count": 9,
                 "annotations": [],
                 "user": {
                     "id": 1404376560,
                     "screen_name": "zaku",
                     "name": "zaku",
                     "province": "11",
                     "city": "5",
                     "location": "北京 朝阳区",
                     "description": "人生五十年，乃如梦如幻；有生斯有死，壮士复何憾。",
                     "url": "http://blog.sina.com.cn/zaku",
                     "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
                     "domain": "zaku",
                     "gender": "m",
                     "followers_count": 1204,
                     "friends_count": 447,
                     "statuses_count": 2908,
                     "favourites_count": 0,
                     "created_at": "Fri Aug 28 00:00:00 +0800 2009",
                     "following": false,
                     "allow_all_act_msg": false,
                     "remark": "",
                     "geo_enabled": true,
                     "verified": false,
                     "allow_all_comment": true,
                     "avatar_large": "http://tp1.sinaimg.cn/1404376560/180/0/1",
                     "verified_reason": "",
                     "follow_me": false,
                     "online_status": 0,
                     "bi_followers_count": 215
                 }
             }
         },
         ...
     ],
     "previous_cursor": 0,
     "next_cursor": 0,
     "total_number": 7
 }

 */




@end
