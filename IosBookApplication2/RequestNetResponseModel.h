//
//  RequestNetResponseModel.h
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/23.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestNetResponseModel : NSObject

@property(nonatomic,strong) NSString *code;
@property(nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSString *content;

+ (instancetype)requestNetWithDict:(NSDictionary *)dict;

@end
