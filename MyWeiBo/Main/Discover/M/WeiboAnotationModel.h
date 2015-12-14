//
//  MapAnotationModel.h
//  MyWeiBo
//
//  Created by imac on 15/12/12.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "WeiboModel.h"
@interface WeiboAnotationModel : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, strong) WeiboModel *model;

@end
