//
//  DataService.m
//  MyWeiBo
//
//  Created by imac on 15/12/10.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "DataService.h"
#import "AFNetworking.h"
#define BaseUrl @"https://open.weibo.cn/2/"

@implementation DataService

+(void)requestUrl:(NSString*)url
       httpMethod:(NSString*)method
           params:(NSMutableDictionary*)params
         fileData:(NSMutableDictionary*)fileDic
          success:(void(^)(id result))successBlock
          failure:(void(^)(NSError *error))failureBlock{

    url = [BaseUrl stringByAppendingString:url];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [defaults objectForKey:@"SinaWeiboAouthData"];
    NSString *accesstoken = dic[@"AccessTokenKey"];
//    NSDictionary *sinaWeiboInfo = [defaults objectForKey:@"SinaWeiboAouthData"];
    
    
    [params setObject:accesstoken forKey:@"access_token"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if ([method caseInsensitiveCompare:@"GET"] == NSOrderedSame) {
        [manager GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            failureBlock(error);
        }];
    }else if ([method caseInsensitiveCompare:@"POST"] == NSOrderedSame){
        
        if (fileDic) {
            
            [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                for (NSString *key in fileDic) {
                    
                    NSData *data = fileDic[key];
                    [formData appendPartWithFileData:data name:key fileName:key mimeType:@"image/tiff"];
                }
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                successBlock(responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                failureBlock(error);
            }];
        }else{
    
        [manager POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            failureBlock(error);
        }];
    }
    
}
}
@end
