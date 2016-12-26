//
//  NetRequestManager.h
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/22.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequestManager : NSObject

//GET网络请求
+(NSString *)getRequestData:(NSString *) urlString;
//POST网络请求
+(NSString *)postRequestData:(NSString *) urlString : (NSDictionary *) dictionary;

@end
