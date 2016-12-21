//
//  SelectLoginViewController.m
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/21.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import "SelectLoginViewController.h"

@interface SelectLoginViewController ()<UINavigationControllerDelegate>

@end

@implementation SelectLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    // Do any additional setup after loading the view.
}
//登录点击
- (IBAction)loginClickFunction:(UIButton *)sender {
    //跳转登录页面
    
}
//随便看看点击
- (IBAction)scanClickFunction:(UIButton *)sender {
    //跳转主页面
    //将我们的storyBoard实例化，“Main”为StoryBoard的名称
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"home" bundle:nil];
    
    SelectLoginViewController *selectContro =  [mainStoryBoard instantiateViewControllerWithIdentifier:@"home_storyboard_page"];
    [self.navigationController pushViewController:selectContro animated:YES];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
