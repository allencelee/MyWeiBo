//
//  MapViewController.h
//  MyWeiBo
//
//  Created by imac on 15/12/12.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import "WeiboAnotationModel.h"
@interface MapViewController : BaseViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@end
