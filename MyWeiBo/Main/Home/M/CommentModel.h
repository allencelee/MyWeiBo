//
//  CommentModel.h
//  MyWeiBo
//
//  Created by imac on 15/12/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "JSONModel.h"
#import "UserModel.h"
@interface CommentModel : JSONModel

@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign)long id;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,copy)NSString *mid;
@property(nonatomic,strong)NSDictionary *user;
@property(nonatomic,strong)NSDictionary *status;
//@property(nonatomic,strong)UserModel *userModel;

@end
