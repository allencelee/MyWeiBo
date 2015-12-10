//
//  DataService.h
//  MyWeiBo
//
//  Created by imac on 15/12/10.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface DataService : NSObject

+(void)requestUrl:(NSString*)url
       httpMethod:(NSString*)method
           params:(NSMutableDictionary*)params
         fileData:(NSMutableDictionary*)fileDic
          success:(void(^) (id result))successBlock
          failure:(void(^)(NSError *error))failureBlock;
@end
