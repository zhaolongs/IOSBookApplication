//
//  LoginViewController.m
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/21.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import "LoginViewController.h"
#import "StringUtls.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *userNameParentView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property (weak, nonatomic) IBOutlet UIButton *weixinButton;
@property (weak, nonatomic) IBOutlet UIButton *qqButton;

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
    
    
    
    
    
    //    [self.userNameParentView.layer setMasksToBounds:YES];
    //    [self.userNameParentView.layer setCornerRadius:4.0]; //设置矩形四个圆角半径
    //    //边框宽度
    //    [self.userNameParentView.layer setBorderWidth:1.0];
    //    //设置边框颜色有两种方法：第一种如下:
    //    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 1 });
    //    [self.userNameParentView.layer setBorderColor:colorref];//边框颜色
    //
    
    [self.loginButton addTarget:self action:@selector(loginClickFunction) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [self.passwordTextField resignFirstResponder];
    [self.userNameTextField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    
    return YES;
    
}

-(void) loginClickFunction{
    NSLog(@"登录请求");
    NSString *userName = self.userNameTextField.text;
    NSString *passWord = self.passwordTextField.text;
    
    if ([StringUtls isEmpty:userName]) {
        NSLog(@"用户名为空");
        [self alertShowFunction:@"用户名不可为空"];
        return;
        
    }
    if ([StringUtls isEmpty:passWord]) {
        NSLog(@"密码为空");
        [self alertShowFunction:@"密码不可为空"];
        return;
    }
    
    //登录
    [self loginToNetFunction:userName :passWord];
}

//提交登录信息到服务器
-(void) loginToNetFunction:(NSString *) username : (NSString *) password{
    NSString *loginUrl = @"http://192.168.0.102:10008/BookStoreProgret/moble/book/login";
    
    //2、请求URL
    NSURL *url = [NSURL URLWithString:loginUrl];
    //3、请求Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4、设置请求方法
    request.HTTPMethod = @"POST";
    //5、设置请求体内容
    NSString *body =[NSString stringWithFormat:@"username=%@&password=%@",username,password];
    //6、将请求体内容转换成二进制
    NSData *bodyData =[body dataUsingEncoding:NSUTF8StringEncoding];
    //7、设置请求体
    request.HTTPBody = bodyData;
    //8、
    [[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *requestString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",requestString);
        NSInteger code =   error.code;
        if (code ==200) {
            NSLog(@"请求服务成功");
            //主线程更新任务
            dispatch_async(dispatch_get_main_queue(), ^{
                //跳转
                [self toHomePageFunction];
            });
            
        }else{
            NSLog(@"请求服务失败");
        }
        
    }] resume];
}

//跳转到主页面
-(void) toHomePageFunction{
    //将我们的storyBoard实例化，“Main”为StoryBoard的名称
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"home" bundle:nil];
    
    LoginViewController *selectContro =  [mainStoryBoard instantiateViewControllerWithIdentifier:@"home_storyboard_page"];
    [self.navigationController pushViewController:selectContro animated:YES];
    
}
-(void) alertShowFunction:(NSString *) msg{
    //创建
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    //添加取消按钮 并设置Block
    [controll addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"CLICK 取消");
    }]];
    //添确认消按钮 并设置Block
    [controll addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"CLICK 确认");
    }]];
    //弹出
    [self presentViewController:controll animated:YES completion:nil];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
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
