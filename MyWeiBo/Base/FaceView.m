//
//  FaceView.m
//  MyWeiBo
//
//  Created by imac on 15/12/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "FaceView.h"


@implementation FaceView


-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self loadFaceFile];
    }
    return self;
}

-(void)loadFaceFile{

    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"emoticons.plist" ofType:nil]];
    _items = [NSMutableArray array];
    NSMutableArray *items2d = nil;
    
    for (int i = 0; i<array.count; i++) {
        
        if (items2d == nil||items2d.count == 28) {
            
            items2d = [NSMutableArray arrayWithCapacity:28];
            [_items addObject:items2d];
        }
        
        NSDictionary *faceDic = [array objectAtIndex:i];
        
        [items2d addObject:faceDic];
    }

    self.width = kScreenWidth *_items.count;
    self.height  = itemWidth * 4;

}

- (void)drawRect:(CGRect)rect {
 
    int colum = 0;
    int row = 0;
    
    for (int i  = 0; i < _items.count; i++) {
        
        NSArray *item2d = _items[i];
        for (int j = 0; j < item2d.count; j++) {
            
            NSDictionary *dic = item2d[j];
            NSString *str = dic[@"png"];
            UIImage *image = [UIImage imageNamed:str];
            
            CGFloat x = colum * itemWidth + (itemWidth-imgWidth)/2 + kScreenWidth*i;
            CGFloat y = row * itemHeight + (itemWidth-imgWidth)/2;
            
            [image drawInRect:CGRectMake(x, y, imgWidth, imgHeight)];
            colum++;
            if (colum == 7) {
                colum = 0;
                row++;
            }
            if (row == 4) {
                
                row = 0;
            }
        }
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    self.imageView.hidden = NO;
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        
        UIScrollView *scrollView = (UIScrollView*)self.superview;
        scrollView.scrollEnabled = NO;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [self touchFace:point];
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [self touchFace:point];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    _imageView.hidden = YES;
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        scrollView.scrollEnabled = YES;
    }
}

-(void)touchFace:(CGPoint)point{

    /**
    *
    CGFloat x = colum * itemsWidth + (itemsWidth-imgWidth)/2 +kScreenWidth *i;
    CGFloat y = row * itemsWidth +(itemsWidth-imgWidth)/2;
    */
    
    //1.确定页数
    NSInteger page = point.x/kScreenWidth;
    //2.确定行列
    int colum = (point.x - (itemWidth-imgWidth)/2-kScreenWidth*page)/itemWidth;
    int row = (point.y-(itemWidth-imgWidth)/2)/itemWidth;
    
    if(colum>6) colum = 6;
    if(colum<0) colum = 0;
    if(row>3) row = 3;
    if(row<0) row = 0;
    //3.确定在数组中的位置
    NSInteger index = row*7+colum;
    if (page == _items.count-1) {
        
        NSArray *item2d = _items[page];
        if (index > item2d.count-1) {
            return;
        }
    }
    //4.取出图片和名字

    NSArray *array = _items[page];
    NSDictionary *faceDic = array[index];
    NSString *imgName = faceDic[@"png"];
    NSString *faceName = faceDic[@"chs"];

    
    NSLog(@"%@",faceName);
    //5.判断放大镜的位置
    
    if (![self.selectedName isEqualToString:faceName]) {
        
        CGFloat x = colum *itemWidth + itemWidth/2 + page*kScreenWidth;
        CGFloat bottom = row *itemHeight + itemHeight/2;
        self.imageView.center = CGPointMake(x, 0);
        self.imageView.bottom = bottom;
        UIImageView *faceImageView = (UIImageView*)[self.imageView viewWithTag:1000];
        faceImageView.image = [UIImage imageNamed:imgName];

        [self addSubview:_imageView];
        
    }
    self.selectedName = faceName;
    
    
    
}



-(UIImageView*)imageView{

    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emoticon_keyboard_magnifier@2x.png"]];
        [_imageView sizeToFit] ;
        _imageView.hidden = YES;
        [self addSubview:_imageView];
        
        UIImageView *faceImageView = [[UIImageView alloc]initWithFrame:CGRectMake((_imageView.width-itemWidth)/2+10, 15, imgWidth, imgHeight)];
        faceImageView.tag = 1000;
        [_imageView addSubview:faceImageView];
    }
    return _imageView;
}


@end
