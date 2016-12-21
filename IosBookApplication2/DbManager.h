//
//  DbManager.h
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/21.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "BookModel.h"

@interface DbManager : NSObject

@property(nonatomic)sqlite3 *dp;


//创建数据库管理者单例
+(instancetype)shareManager;
//+(void)applicationDocumentPath;
//+(void)createDataBaseTable;

//查询所有书籍信息
+(NSMutableArray *)queryAllBookLst;

//查询指定书籍信息
+(BookModel *) queryBookModel: (NSString *) name;
//插入数据
+(BOOL) insertBookModel: (BookModel *) bookModel;

//修改数据
+(void) updateBookModel: (BookModel *) bookModel;

//删除数据
+(void) deleteBookModel: (NSString *) name;


@end
