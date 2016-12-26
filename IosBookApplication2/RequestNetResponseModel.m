//
//  RequestNetResponseModel.m
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/23.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import "RequestNetResponseModel.h"

@implementation RequestNetResponseModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        //[self setValuesForKeysWithDictionary:dict];
        self.message = [dict objectForKey:@"message"];
        self.code = [dict objectForKey:@"code"];
        self.content = [dict objectForKey:@"content"];
    }
    return self;
}

+ (instancetype)requestNetWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


@end
