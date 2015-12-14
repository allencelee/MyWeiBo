//
//  EditorViewController.m
//  MyWeiBo
//
//  Created by imac on 15/12/10.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SendViewController.h"

#define itemWidth (kScreenWidth/7)
#define itemHeight (kScreenWidth/7)

@interface SendViewController ()
{

    UIScrollView *myScrollView;
    FaceView *view;
    UIView *baseView;
    NSString *address;
    
}
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIView *editView;
@property(nonatomic,strong)UIImage *sendImg;
@property(nonatomic,strong)CLLocationManager *manager;
@end

@implementation SendViewController{

    MBProgressHUD *hudSend;
    UIPageControl *pageC;
    MBProgressHUD *addreHud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNaviButton];
    [self creatEditorView];
    [self creatFaceView];
    
}

-(instancetype)init{
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillHideNotification object:nil];

    }
    return self;
}

-(void)creatNaviButton{

    ThemeButton *closeButton = [[ThemeButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    closeButton.imgName =@"button_icon_close.png";
    [closeButton addTarget:self action:@selector(clsoseAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:closeButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    ThemeButton *sendButton = [[ThemeButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    sendButton.imgName = @"button_icon_ok.png";
    [sendButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}


-(void)creatEditorView{
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-55)];
    _textView.backgroundColor = [UIColor clearColor];
    [_textView becomeFirstResponder ];
    [self.view addSubview:_textView];
    
    _editView = [[UIView alloc]initWithFrame:CGRectMake(0, _textView.bottom, kScreenWidth, 55)];
    _editView.backgroundColor = [UIColor clearColor];
    
    NSArray *buttonName = @[
                            @"compose_toolbar_1.png",
                            @"compose_toolbar_4.png",
                            @"compose_toolbar_3.png",
                            @"compose_toolbar_5.png",
                            @"compose_toolbar_6.png"
                            ];

    for (int i = 0; i<buttonName.count; i++) {
        
        ThemeButton *button = [[ThemeButton alloc]initWithFrame:CGRectMake(i*(kScreenWidth/5)+20,10, 40, 35)];
        button.imgName = buttonName[i];
        button.tag = 1000+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_editView addSubview:button];
    }
    
    [self.view addSubview:_editView];
}

-(void)clsoseAction{

    MMDrawerController *drawController = (MMDrawerController*)self.view.window.rootViewController;
    [drawController closeDrawerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendAction{

    NSString *message = nil;
    
    if (_textView.text.length == 0) {
        message = @"啥都没写，发个j8";
    }else if (_textView.text.length > 140){
        
        message = @"内容太j8长了，少写点";
        
    }else{
         hudSend = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hudSend.labelText = @"正在发送。。。";

        
    }
    
    if (message != nil) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }

    [self sendStatus];
}

-(void)sendStatus{

    
    NSString *urlString = nil;
    NSDictionary *fileDic = nil;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"status":_textView.text}];
    
    if (_sendImg) {
        
        urlString = @"statuses/upload.json";
        
        NSData *imageData = UIImageJPEGRepresentation(_sendImg, 1);
        if (imageData.length > 3*1024*1024) {
            imageData = UIImageJPEGRepresentation(_sendImg, 0.5);
        }
        fileDic = @{@"pic":imageData};
        
        [DataService requestUrl:urlString httpMethod:@"POST" params:params fileData:[fileDic mutableCopy] success:^(id result) {

            hudSend.hidden = YES;
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37x-Checkmark@2x.png"]];
            hud.labelText = @"发送成功";
            [hud hide:YES afterDelay:1];
            
            
            
            
        } failure:^(NSError *error) {
            NSLog(@"发送失败，%@",error);
        }];
    }else{
    
        NSString *urlString = @"statuses/update.json";
        
        [DataService requestUrl:urlString httpMethod:@"POST" params:params fileData:[fileDic mutableCopy] success:^(id result) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37x-Checkmark@2x.png"]];
            hud.labelText = @"发送成功";
            [hud hide:YES afterDelay:2];
            

        } failure:^(NSError *error) {
            NSLog(@"发送失败，%@",error);
        }];

    }
}

-(void)keyboardShow:(NSNotification*)noti{

    NSValue *value = noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"];
    CGRect frame = [value CGRectValue];
    CGFloat height = frame.size.height;
    if ([noti.name isEqualToString:@"UIKeyboardWillShowNotification"]) {
        _textView.height = kScreenHeight - height - 64-55;
        _editView.top = _textView.bottom;
    }else if ([noti.name isEqualToString:@"UIKeyboardWillHideNotification"]){
    
        _textView.height = kScreenHeight - 64- 55;
        _editView.top = _textView.bottom;
    }
}

-(void)buttonAction:(UIButton*)button{

    if (button.tag == 1000) {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        [sheet showInView:self.view];
    }
    
    if (button.tag == 1004) {
        
        if ([_textView isFirstResponder]) {
            
            [self showFaceVeiw];
        }else{
        
            [self hiddenFaceVeiw];
        }
    }
    if (button.tag == 1003) {
        
        [self location];
    }
}
-(void)location{

    //1.创建定位管理者
    _manager = [[CLLocationManager alloc]init];
    //是否开启定位服务
    if ([CLLocationManager locationServicesEnabled] ) {
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
            //是否授权
            [_manager requestWhenInUseAuthorization];
        }else{
        
            addreHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            addreHud.labelText = @"正在定位";
            
            _manager.desiredAccuracy = kCLLocationAccuracyBest;
            _manager.delegate = self;
            [_manager startUpdatingLocation];
        }
    }
}


-(void)creatFaceView{
    

    self.automaticallyAdjustsScrollViewInsets = NO;
    view = [[FaceView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.backgroundColor = [UIColor clearColor];
    [view addObserver:self forKeyPath:@"selectedName" options:NSKeyValueObservingOptionNew context:nil];
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, view.height)];
    myScrollView.showsHorizontalScrollIndicator = NO;
    
    myScrollView.delegate = self;
    myScrollView.clipsToBounds = NO;
    
    myScrollView.contentSize = CGSizeMake(view.width, view.height);
    [myScrollView addSubview:view];
    myScrollView.pagingEnabled = YES;
    
    //添加pageControl
    pageC = [[UIPageControl alloc]initWithFrame:CGRectMake(0, myScrollView.bottom, kScreenWidth, 20)];
    pageC.numberOfPages = view.items.count;
    
    baseView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-64, kScreenWidth, view.height + pageC.height)];
    baseView.backgroundColor = [UIColor grayColor];
    
    [baseView addSubview:pageC];
    [baseView addSubview:myScrollView];
    [self.view addSubview:baseView];
    
}

-(void)showFaceVeiw{
    
    [_textView resignFirstResponder];
 
    
    [UIView animateWithDuration:0.3 animations:^{
        baseView.transform = CGAffineTransformMakeTranslation(0, -baseView.height);
        _editView.bottom = baseView.top;
        _textView.height = baseView.height + _editView.height;
    }];
}

-(void)hiddenFaceVeiw{

    [_textView becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        
        baseView.transform = CGAffineTransformIdentity;
    }];
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 1) {
        UIImagePickerController *pick = [[UIImagePickerController alloc]init];
        pick.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pick.delegate = self;
        [self presentViewController:pick animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 40, 35)];
    
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    imageV.image = image;
    _sendImg = image;
    [_editView addSubview:imageV];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    int index = scrollView.contentOffset.x/kScreenWidth;
    pageC.currentPage = index;
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    NSString *faceName = [change objectForKey:@"new"];
    _textView.text = [NSString stringWithFormat:@"%@%@",_textView.text,faceName];
}

-(void)dealloc{

    [view removeObserver:self forKeyPath:@"selectedName"];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    [_manager stopUpdatingLocation];
    //位置信息
    CLLocation *location = [locations lastObject];
    //经纬度
    CLLocationCoordinate2D coordinate2D = location.coordinate;
    
    double latitude = coordinate2D.latitude;
    double longitude = coordinate2D.longitude;
    
    //新浪反编码
    
    /*
    NSString *string = [NSString stringWithFormat:@"%f,%f",longitude,latitude];
    NSDictionary *dic = @{@"coordinate":string};
    [DataService requestUrl:@"location/geo/geo_to_address.json" httpMethod:@"GET" params:[dic mutableCopy] fileData:nil success:^(id result) {
        NSLog(@"请求成功");
        [addreHud hide:YES];
        NSArray *arr = result[@"geos"];
        NSDictionary *dic = [arr lastObject];
        address = dic[@"address"];
        NSLog(@"%@",address);
        
        [self showDistance];
        
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
     */
    //ios反编码
    
    CLGeocoder *coder = [[CLGeocoder alloc]init];
    
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *mark = [placemarks lastObject];

        NSDictionary *dic = mark.addressDictionary;
        
//        address = mark.name;
//        address = dic[@"Name"];
        NSString *string = [NSString stringWithFormat:@"%@%@%@%@%@",dic[@"Country"],dic[@"City"],dic[@"SubLocality"],dic[@"Street"],dic[@"Name"]];
        address = string;
        [self showDistance];
        [addreHud hide:YES];
    }];
    
    
    NSLog(@"%@",location);
}

-(void)showDistance{

    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, _editView.top-30, kScreenWidth-20, 30)];
    lable.text = address;
    [self.view addSubview:lable];
}
@end
