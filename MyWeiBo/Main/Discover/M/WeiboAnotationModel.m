//
//  MapAnotationModel.m
//  MyWeiBo
//
//  Created by imac on 15/12/12.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "WeiboAnotationModel.h"

@implementation WeiboAnotationModel

-(void)setModel:(WeiboModel *)model{

    _model = model;
    NSArray *coordinate = _model.geo[@"coordinates"];
    
    double lat = [coordinate[0] doubleValue];
    double longi = [coordinate[1] doubleValue];
    
    self.coordinate = CLLocationCoordinate2DMake(lat, longi);
}

@end
