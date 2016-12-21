//
//  LoginViewController.m
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/21.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *userNameParentView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@property (weak, nonatomic) IBOutlet UISwitch *isAutoLogin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置输入框的颜色
    self.userNameTextField.backgroundColor = [[UIColor alloc]initWithRed:222 green:222 blue:222 alpha:0];
    self.passwordTextField.backgroundColor = [[UIColor alloc]initWithRed:222 green:222 blue:222 alpha:0];
    //设置提示文字
    self.userNameTextField.placeholder = @"请输入用户名";
    self.passwordTextField.placeholder = @"请输入密码";
    //设置边框样式
    self.userNameTextField.borderStyle = UITextBorderStyleNone;
    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    
    //按return键键盘往下收  becomeFirstResponder
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    //    声明text的代理是我，我会去实现把键盘往下收的方法 这个方法在UITextFieldDelegate里所以我们要采用UITextFieldDelegate这个协议
    
    
    self.isAutoLogin.onTintColor = [UIColor colorWithRed:0.984 green:0.478 blue:0.224 alpha:1.000];
    // 控件大小，不能设置frame，只能用缩放比例
    self.isAutoLogin.transform = CGAffineTransformMakeScale(0.75, 0.75);
    // 控件开关
    if ( self.isAutoLogin) {
        self.isAutoLogin.on = NO;
    }else{
        self.isAutoLogin.on = YES;
    }
    
    
    [self.loginButton.layer setMasksToBounds:YES];
    [self.loginButton.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
    //边框宽度
    [self.loginButton.layer setBorderWidth:1.0];
    //设置边框颜色有两种方法：第一种如下:
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 1 });
    [self.loginButton.layer setBorderColor:colorref];//边框颜色
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [self.passwordTextField resignFirstResponder];
    [self.userNameTextField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    
    return YES;
    
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
