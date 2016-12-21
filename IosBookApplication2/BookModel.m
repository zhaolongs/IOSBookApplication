//
//  BookModel.m
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/21.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        //[self setValuesForKeysWithDictionary:dict];
        self.id = [dict objectForKey:@"id"];
        self.name = [dict objectForKey:@"name"];
        
        self.author = [dict objectForKey:@"author"];
        self.path = [dict objectForKey:@"path"];
        
        self.price = [dict objectForKey:@"price"];
        self.filename = [dict objectForKey:@"filename"];
        
        self.descriptions = [dict objectForKey:@"description
                             "];
    }
    return self;
}

+ (instancetype)bookModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}


@end
