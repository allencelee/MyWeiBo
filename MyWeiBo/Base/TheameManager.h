//
//  TheameManager.h
//  MyWeiBo
//
//  Created by imac on 15/12/1.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TheameManager : NSObject
@property(nonatomic,copy)NSString *theameName;
@property(nonatomic,strong)NSDictionary *dic;
+(id)sharedInstance;
-(UIImage *)getTheameImage:(NSString *)imageName;
@end
