//
//  UserModel.h
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/23.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *age;
@property(nonatomic,strong) NSString *sex;
@property(nonatomic,strong) NSString *introduce;


+(instancetype) userModelInitWithDict:(NSDictionary *) diction;
@end
