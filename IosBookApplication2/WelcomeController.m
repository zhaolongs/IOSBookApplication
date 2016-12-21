//
//  WelcomeController.m
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/21.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import "WelcomeController.h"
#import "HomeViewController.h"
#import "SelectLoginViewController.h"


static int isautoSelect=0;

@interface WelcomeController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *singleLabel3;
@property (weak, nonatomic) IBOutlet UILabel *singleLabel2;

@property (weak, nonatomic) IBOutlet UILabel *singleLabel1;

@property (nonatomic, strong) NSTimer *timer;@end

@implementation WelcomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
    
    [UIView animateWithDuration:1.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut animations:^(void){
                            _singleLabel1.alpha = 1.0;
                        }completion:^(BOOL finished){
                            
                            
                        }];
    
    [UIView animateWithDuration:1
                          delay:0.3
                        options:UIViewAnimationOptionCurveEaseOut animations:^(void){
                            self.singleLabel2.alpha = 1.0;
                        }completion:^(BOOL finished){
                            
                            
                        }];
    
    [UIView animateWithDuration:0.6
                          delay:0.6
                        options:UIViewAnimationOptionCurveEaseOut animations:^(void){
                            self.singleLabel3.alpha = 1.0;
                        }completion:^(BOOL finished){
                            
                            
                        }];
    if (isautoSelect ==0) {
        isautoSelect =1;
        if(_timer==nil){
            NSLog(@"初始化 timer");
            _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(opentSelectPage) userInfo:nil repeats:NO];
            
            
        }else{
            if (_timer.isValid){
                [_timer invalidate];
            }
        }
    }
}

-(void) opentSelectPage{
    NSLog(@"延时任务执行");
    
    //自动跳转
    
    //已登录 跳转首页
    
    
    //未登录 跳转选择进入页面
    
    //将我们的storyBoard实例化，“Main”为StoryBoard的名称
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    SelectLoginViewController *selectContro =  [mainStoryBoard instantiateViewControllerWithIdentifier:@"select_login_controller"];
    [self.navigationController pushViewController:selectContro animated:YES];
    
    
    
    //[self.timer invalidate];
    //SelectLoginViewController *selectController = [[SelectLoginViewController alloc]init];
    //    [self presentModalViewController:selectController animated:YES];
    
    
    
    //[self.navigationController pushViewController:selectController animated:YES];
    
    
    //[self shouldPerformSegueWithIdentifier:@"to_select_login" sender:nil];
    
}
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
