//
//  BookModel.h
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/21.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModel : NSObject

@property(nonatomic,copy) NSString *id;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *author;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *path;
@property(nonatomic,copy) NSString *filename;

@property(nonatomic,copy ) NSString *descriptions;

@property(nonatomic,copy) NSString *catograyId;

+ (instancetype)bookModelWithDict:(NSDictionary *)dict;

@end
