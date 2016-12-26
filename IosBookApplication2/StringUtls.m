//
//  StringUtls.m
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/23.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import "StringUtls.h"

@implementation StringUtls


+(BOOL)isEmpty:(NSString *)string{
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


@end
