//
//  AppDelegate.m
//  MyWeiBo
//
//  Created by imac on 15/12/1.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *MyWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    MyWindow.backgroundColor = [UIColor whiteColor];
    self.window  = MyWindow;
    [self.window makeKeyAndVisible];
    //加载左右滑动视图
    UIStoryboard *leftS = [UIStoryboard storyboardWithName:@"Left" bundle:nil];
    UIStoryboard *rightS = [UIStoryboard storyboardWithName:@"Right" bundle:nil];
   
    UINavigationController *leftC = [leftS instantiateInitialViewController];
    UINavigationController *rightC = [rightS instantiateInitialViewController];
    BaseTabBarViewController *tabC = [[BaseTabBarViewController alloc]init];
    
    self.drawController = [[MMDrawerController alloc]initWithCenterViewController:tabC leftDrawerViewController:leftC rightDrawerViewController:rightC];
    [self.drawController setMaximumLeftDrawerWidth:180.0];
    [self.drawController setMaximumRightDrawerWidth:60.0];
    [self.drawController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    
    [self.drawController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         //提供滑动的样式的单例（这个类并没有加在框架内，使用的时候直接将文件加入框架内就可以）
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    self.window.rootViewController = self.drawController;
  
    [self setSinaWeiboSDk];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeAuthData) name:@"logout" object:nil];
    return YES;
}

//集成新浪sdk
-(void)setSinaWeiboSDk{

    _sinaWeibo = [[SinaWeibo alloc ]initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaWeiboInfo = [defaults objectForKey:@"SinaWeiboAouthData"];
    if ([sinaWeiboInfo objectForKey:@"AccessTokenKey"] && [sinaWeiboInfo objectForKey:@"ExpirationDateKey"] && [sinaWeiboInfo objectForKey:@"UserIDKey"]) {
        
        _sinaWeibo.accessToken = [sinaWeiboInfo objectForKey:@"AccessTokenKey"];
        _sinaWeibo.expirationDate = [sinaWeiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaWeibo.userID = [sinaWeiboInfo objectForKey:@"UserIDKey"];
    }
}

-(void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{

    [self storeAuthData];
    

    
}

-(void)storeAuthData{

    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              
                              _sinaWeibo.accessToken,@"AccessTokenKey" ,
                              _sinaWeibo.expirationDate,@"ExpirationDateKey",
                              _sinaWeibo.userID,@"UserIDKey",
                              _sinaWeibo.refreshToken, @"refresh_token",nil
                              
                              ];
    
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAouthData"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

-(void)removeAuthData{

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAouthData"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[self sinaWeibo] logOut];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
