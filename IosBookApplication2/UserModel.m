//
//  UserModel.m
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/23.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.id = [dict objectForKey:@"id"];
        self.username = [dict objectForKey:@"username"];
        
        self.sex = [dict objectForKey:@"sex"];
        self.age = [dict objectForKey:@"age"];
        
        self.introduce = [dict objectForKey:@"instroduce"];
    }
    return self;
}
+(instancetype)userModelInitWithDict:(NSDictionary *)diction{
    return [[self alloc]initWithDict:diction];
}

@end
