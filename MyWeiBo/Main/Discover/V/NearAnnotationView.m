//
//  NearAnnotationView.m
//  MyWeiBo
//
//  Created by imac on 15/12/12.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "NearAnnotationView.h"

@implementation NearAnnotationView

-(instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        
        [self creatSubview];
    }
    return self;
}

-(void)creatSubview{

    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nearby_map_people_bg@2x.png"]];
    [imageView sizeToFit];
    [self addSubview:imageView];
    
    UIImageView *userImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 50, 50)];
    WeiboAnotationModel *annotation = (WeiboAnotationModel*) self.annotation;
    NSURL *url = [NSURL URLWithString:annotation.model.user.profile_image_url];
    [userImg sd_setImageWithURL:url];
    [imageView addSubview:userImg];
}
@end
