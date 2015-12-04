//
//  UserModel.m
//  MyWeiBo
//
//  Created by imac on 15/12/4.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                      @"description":@"desc"
                                                       }];
}

@end
