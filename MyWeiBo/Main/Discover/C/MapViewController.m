//
//  MapViewController.m
//  MyWeiBo
//
//  Created by imac on 15/12/12.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MapViewController.h"
#import "NearAnnotationView.h"
#import "WeiboAnotationModel.h"
#import "DataService.h"
@interface MapViewController ()
@property(nonatomic,strong)CLLocationManager *manager;
@property(nonatomic,strong)MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showMap];
    
}

-(void)showMap{

    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    _manager = [[CLLocationManager alloc]init];
    _manager.delegate = self;
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    [_manager startUpdatingLocation];
    
    /*
    //创建标注视图
     WeiboAnotationModel *weiboAnotation = [[WeiboAnotationModel alloc]init];
    weiboAnotation.coordinate = CLLocationCoordinate2DMake(39.901, 116.203);
    weiboAnotation.title = @"wxhl";
    [_mapView addAnnotation:weiboAnotation];
    */
    
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{

    [_manager stopUpdatingLocation];
    CLLocation *location = [locations lastObject];
    
    CLLocationCoordinate2D coordinate2D = location.coordinate;
    [self loadData:coordinate2D];
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate2D, span);
    [_mapView setRegion:region animated:YES];
    
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *identy = @"map";
    NearAnnotationView *view = (NearAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:identy];
    if (view == nil) {
        view = [[NearAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identy];
        view.canShowCallout = YES;
    }
    return view;
}

-(void)loadData:(CLLocationCoordinate2D)coordinate{

    NSDictionary *dic = @{
                          @"lat":[NSString stringWithFormat:@"%f",coordinate.latitude],
                          @"long":[NSString stringWithFormat:@"%f",coordinate.longitude]
                          };
    [DataService requestUrl:@"place/nearby_timeline.json" httpMethod:@"GET" params:[dic mutableCopy]  fileData:nil success:^(id result) {
        
        NSArray *modelArr = result[@"statuses"];
        NSMutableArray *data = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in modelArr) {
            
            WeiboModel *weiboModel = [[WeiboModel alloc]initWithDictionary:dic error:nil];
            WeiboAnotationModel *anotation = [[WeiboAnotationModel alloc]init];
            
            anotation.model = weiboModel;
            [data addObject:anotation];
            
        }
        [_mapView addAnnotations:data];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
