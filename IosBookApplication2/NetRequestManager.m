//
//  NetRequestManager.m
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/22.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import "NetRequestManager.h"

@implementation NetRequestManager



+(NSString *)getRequestData:(NSString *)urlString{
    // 1、构造URL资源地址
    NSURL *url = [NSURL URLWithString:urlString];
    // 2、创建Request请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 3、配置Request请求
    // 3.1 配置请求方法
    request.HTTPMethod=@"GET";
    // 3.2 设置请求超时
    request.timeoutInterval =30.0;
    // 4、构建 NSURLSessionConfiguration
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 5、构造 NSURLSession 网络会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration: configuration];
    // 6、构造 NSURLSessionTask 会话任务
    NSURLSessionTask *task  = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //请求异常
        if (error) {
            NSLog(@"网络访问 异常 %@",error.localizedDescription);
        }else{
            // 直接将data数据转成OC字符串(NSUTF8StringEncoding)；
            // NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            // JSON数据格式解析
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            // 9、判断是否解析成功
            if (error) {
                NSLog(@"解析异常 %@ ",error.localizedDescription);
            }else {
                // 解析成功，处理数据，通过GCD获取主队列，在主线程中刷新界面。
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 刷新界面....
                });
            }
        }
    }];
    
    //最后执行任务
    [task resume];
    
    return nil;
}
+(NSString *)postRequestData:(NSString *)urlString :(NSDictionary *)dictionary{
    
    // 1、创建URL资源地址
    NSURL *url = [NSURL URLWithString:urlString];
    // 2、创建Reuest请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 3、配置Request
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    // 4、构造请求参数
    // 4.2、遍历字典，以“key=value&”的方式创建参数字符串。
    NSMutableString *parameterString = [NSMutableString string];
    
    for (NSString *key in dictionary.allKeys) {
        // 拼接字符串
        [parameterString appendFormat:@"%@=%@&", key, dictionary[key]];
    }
    // 4.3、截取参数字符串，去掉最后一个“&”，并且将其转成NSData数据类型。
    NSData *parametersData = [[parameterString substringToIndex:parameterString.length - 1] dataUsingEncoding:NSUTF8StringEncoding];
    
    // 5、设置请求报文
    request.HTTPBody = parametersData;
    // 6、构造NSURLSessionConfiguration
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 7、创建网络会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    // 8、创建会话任务
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 10、判断是否请求成功
        if (error) {
            NSLog(@"请求异常 %@",error.localizedDescription);
        }else {
            // 如果请求成功，则解析数据。
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            // 11、判断是否解析成功
            if (error) {
               NSLog(@"解析数据异常 %@",error.localizedDescription);
            }else {
                // 解析成功，处理数据，通过GCD获取主队列，在主线程中刷新界面。
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 刷新界面...
                });
            }
        }
        
    }];
    // 9、执行任务
    [task resume];
    return nil;
}








































@end
