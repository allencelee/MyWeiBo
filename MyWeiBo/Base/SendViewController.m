//
//  EditorViewController.m
//  MyWeiBo
//
//  Created by imac on 15/12/10.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "SendViewController.h"

@interface SendViewController ()
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIView *editView;
@property(nonatomic,strong)UIImage *sendImg;
@end

@implementation SendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNaviButton];
    [self creatEditorView];
    
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
    _editView.backgroundColor = [UIColor blackColor];
    
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

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"status":_textView.text}];
    NSData *imageData = UIImageJPEGRepresentation(_sendImg, 1);
    if (imageData.length > 3*1024*1024) {
        imageData = UIImageJPEGRepresentation(_sendImg, 0.5);
    }
    NSDictionary *fileDic = @{@"pic":imageData};
    
    [DataService requestUrl:@"statuses/upload.json" httpMethod:@"POST" params:params fileData:[fileDic mutableCopy] success:^(id result) {
        NSLog(@"发送成功");
    } failure:^(NSError *error) {
        NSLog(@"发送失败，%@",error);
    }];
    
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

@end
