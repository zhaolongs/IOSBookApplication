//
//  DbManager.m
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/21.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import "DbManager.h"



#define DBNAME @"book_application" //数据库名字
#define Book_TBNAME @"books" //表名
#define DBVERSION 1      //数据库版本
#define DBVERSIONKEY @"dbversion_key" //存储数据库版本key

static DbManager *instance=nil;



@interface DbManager()





@end

@implementation DbManager

-(instancetype)init
{
    self=[super init];
    if (self) {
        [self createDataBaseTable];
    }
    return self;
}

//创建数据库管理者单例
+(instancetype)shareManager
{
    if(instance==nil){
        @synchronized(self){
            if(instance==nil){
                instance =[[[self class]alloc]init];
            }
        }
    }
    return instance;
}

-(id)copyWithZone:(NSZone *)zone
{
    
    return instance;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    if(instance==nil){
        instance =[super allocWithZone:zone];
    }
    return instance;
}

//获取路径
-(NSString *) applicationDocumentPath{
    //获取Document 路径
    NSString *documentPaht = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //创建拼接数据库路径
    NSString *sqlitPath = [documentPaht stringByAppendingPathComponent:@"book.sqlite"];
    
    return sqlitPath;
}

//创建数据库
-(void) createDataBaseTable {
    //1、数据库地址
    NSString *writeTablePath =[self applicationDocumentPath];
    
    //2、打开数据库
    //参数一 数据的完整路径
    //参数二 数据库  dataBase对象
    int openDbResult = sqlite3_open([writeTablePath UTF8String], &_dp);
    if(openDbResult!=SQLITE_OK){
        //数据库打开失败
        NSLog(@"数据库打开失败");
        //关闭数据库
        sqlite3_close(_dp);
        //抛出错误信息
        NSAssert(NO, @"数据库打开失败");
    }else{
        //数据库打开成功
        NSLog(@"数据库打开成功");
        
        //3、创建表
        char *err;
        // 3.1 创建表SQL语句
        NSString *createTable =
        [NSString stringWithFormat:
         @"create table if not exists books (id text primary key,name text,author text,price text ,path text,filename text,description text,catograyIdtext);"];
        // 3.2 执行sql
        //参数一  dp对象
        //参数二  sql语句
        //参数三  回调函数传参数
        //参数四   回调函数传参数
        //参数五   错误信息
        int createResult = sqlite3_exec(_dp, [createTable UTF8String], NULL, NULL, &err);
        if(createResult!=SQLITE_OK){
            //失败
            //抛出错误信息
            NSAssert(NO, @"建表失败");
        }else{
            //成功
            
            NSLog(@"建表成功");
        };
        
        //4、关闭数据库
        sqlite3_close(_dp);
    };
}

//查询所有的书籍信息
+(NSMutableArray *)queryAllBookLst{
    NSMutableArray *arr = [NSMutableArray array];
    //1、获取数据库路径
    //获取Document 路径
    NSString *documentPaht = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //创建拼接数据库路径
    NSString *sqlitPath = [documentPaht stringByAppendingPathComponent:@"book.sqlite"];
    
    
    sqlite3 *databases;
    //2、打开数据数据库
    int openDbResult = sqlite3_open([sqlitPath UTF8String], &databases);
    if (openDbResult!=SQLITE_OK) {
        //数据库打开失败
        NSLog(@"数据库打开失败");
        //关闭数据库
        sqlite3_close(databases);
        //抛出错误信息
        NSAssert(NO, @"数据库打开失败");
    } else {
        //打开成功
        // 3、创建查询 SQL语句
        NSString *sql = @"select * from books ";
        // 4、定义对象(语句对象 )
        sqlite3_stmt *statemt ;
        
        // 5、执行处理
        //参数一  数据库db对象
        //参数二 sql语句
        //参数三 sql语句执行的长度 （传 -1 表示 sql语句全部执行）
        //参数四 语句对象
        //参数五 没有执行语句的部分
        int  prepareResult = sqlite3_prepare_v2(databases, [sql UTF8String], -1, &statemt, NULL);
        
        
        if (prepareResult!=0) {
            //失败
        } else {
            //成功
            //6、执行查询操作
            //int result = sqlite3_step(statemt);
            //返回值
            while (sqlite3_step(statemt) == SQLITE_ROW) {
                
                BookModel *newModel = [[BookModel alloc]init];
                
                
                //7、获取数据
                //查询成功
                //提取数据
                //参数一 语句对象
                //参数二 字段的索引
                char *id = (char *) sqlite3_column_text(statemt, 0);
                NSString *idString;
                if (id!=nil) {
                    idString = [[NSString alloc]initWithUTF8String:id];
                }
                
                
                char *userName = (char *) sqlite3_column_text(statemt, 1);
                NSString *userNameString;
                if (userName!=nil) {
                    userNameString=[[NSString alloc]initWithUTF8String:userName];
                }
                
                
                char *author =(char *) sqlite3_column_text(statemt, 2);
                NSString *authorStrng;
                if (author!=nil) {
                    authorStrng = [[NSString alloc]initWithUTF8String:author];
                    
                }
                char *price =(char *) sqlite3_column_text(statemt, 3);
                NSString *priceStrng;
                if (price) {
                    priceStrng = [[NSString alloc]initWithUTF8String:price];
                    
                }
                
                char *path =(char *) sqlite3_column_text(statemt, 4);
                NSString *pathString;
                if (path!=nil) {
                    pathString = [[NSString alloc]initWithUTF8String:path];
                }
                
                
                char *filename =(char *) sqlite3_column_text(statemt, 5);
                NSString *filenameString ;
                if (filename!=nil) {
                    filenameString = [[NSString alloc]initWithUTF8String:filename];
                    
                }
                
                char *description =(char *) sqlite3_column_text(statemt, 6);
                NSString *descriptionString;
                if (description!=nil) {
                    descriptionString = [[NSString alloc]initWithUTF8String:description];
                    
                }
                
                char *catograyIdtext =(char *) sqlite3_column_text(statemt, 7);
                NSString *catograyIdtextString;
                if (catograyIdtext!=nil) {
                    catograyIdtextString = [[NSString alloc]initWithUTF8String:catograyIdtext];
                }
                
                newModel.id = idString;
                newModel .name = userNameString;
                newModel .author = authorStrng;
                newModel.price = priceStrng;
                newModel.path = pathString;
                
                newModel.filename = filenameString;
                newModel.descriptions = descriptionString;
                newModel.catograyId = catograyIdtextString;
                
                [arr addObject:newModel];
                
            }
            //8、释放资源
            sqlite3_finalize(statemt);
        }
        
    }
    
    
    return arr;
}


+(BookModel *) queryBookModel:(NSString *)name{
    
    //1、获取数据库路径
    //获取Document 路径
    NSString *documentPaht = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //创建拼接数据库路径
    NSString *sqlitPath = [documentPaht stringByAppendingPathComponent:@"book.sqlite"];
    
    
    sqlite3 *databases;
    //2、打开数据数据库
    int openDbResult = sqlite3_open([sqlitPath UTF8String], &databases);
    if (openDbResult!=SQLITE_OK) {
        //数据库打开失败
        NSLog(@"数据库打开失败");
        //关闭数据库
        sqlite3_close(databases);
        //抛出错误信息
        NSAssert(NO, @"数据库打开失败");
    } else {
        //打开成功
        // 3、创建查询 SQL语句
        NSString *sql = @"select * from books where name = ?";
        // 4、定义对象(语句对象 )
        sqlite3_stmt *statemt ;
        
        // 5、执行处理
        //参数一  数据库db对象
        //参数二 sql语句
        //参数三 sql语句执行的长度 （传 -1 表示 sql语句全部执行）
        //参数四 语句对象
        //参数五 没有执行语句的部分
        int  prepareResult = sqlite3_prepare_v2(databases, [sql UTF8String], -1, &statemt, NULL);
        
        //绑定数据
        sqlite3_bind_text(statemt,1, [name UTF8String], -1, NULL);
        
        
        if (prepareResult!=SQLITE_DONE) {
            //失败
        } else {
            //成功
            //6、执行查询操作
            //返回值
            while (sqlite3_step(statemt) == SQLITE_ROW) {
                
                BookModel *newModel = [[BookModel alloc]init];
                
                
                //7、获取数据
                //查询成功
                //提取数据
                //参数一 语句对象
                //参数二 字段的索引
                char *id = (char *) sqlite3_column_text(statemt, 0);
                NSString *idString = [[NSString alloc]initWithUTF8String:id];
                
                char *userName = (char *) sqlite3_column_text(statemt, 1);
                //数据转换
                NSString *userNameString =[[NSString alloc]initWithUTF8String:userName];
                
                char *author =(char *) sqlite3_column_text(statemt, 2);
                NSString *authorStrng = [[NSString alloc]initWithUTF8String:author];
                
                char *price =(char *) sqlite3_column_text(statemt, 3);
                NSString *priceStrng = [[NSString alloc]initWithUTF8String:price];
                
                char *path =(char *) sqlite3_column_text(statemt, 4);
                NSString *pathString = [[NSString alloc]initWithUTF8String:path];
                
                
                char *filename =(char *) sqlite3_column_text(statemt, 5);
                NSString *filenameString = [[NSString alloc]initWithUTF8String:filename];
                
                
                
                char *description =(char *) sqlite3_column_text(statemt, 6);
                NSString *descriptionString = [[NSString alloc]initWithUTF8String:description];
                
                
                char *catograyIdtext =(char *) sqlite3_column_text(statemt, 7);
                NSString *catograyIdtextString = [[NSString alloc]initWithUTF8String:catograyIdtext];
                
                
                
                newModel.id = idString;
                newModel .name = userNameString;
                newModel .author = authorStrng;
                newModel.price = priceStrng;
                newModel.path = pathString;
                
                newModel.filename = filenameString;
                newModel.descriptions = descriptionString;
                newModel.catograyId = catograyIdtextString;
                
                return newModel;
            }
            //8、释放资源
            sqlite3_finalize(statemt);
        }
        
    }
    
    return nil;
}


+(void)deleteBookModel:(NSString *)name{
    //打开数据库
    //1、获取数据库路径
    //1、获取数据库路径
    //获取Document 路径
    NSString *documentPaht = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //创建拼接数据库路径
    NSString *sqlitPath = [documentPaht stringByAppendingPathComponent:@"book.sqlite"];
    
    sqlite3 *db;
    //2、打开数据库
    int opentResult =sqlite3_open([sqlitPath UTF8String], &db);
    if (opentResult==SQLITE_OK) {
        //打开成功
        
        //1、查询元素是否存在
        //1.1 查询sql 查询标准是 name
        NSString *quertString = @"select * from books where name = ?";
        //1.2 创建查询语句对象
        sqlite3_stmt *querStmt;
        //1.3 执行预处理
        sqlite3_prepare_v2(db, [quertString UTF8String], -1, &querStmt, NULL);
        //1.4 绑定数据
        sqlite3_bind_text(querStmt,1, [name UTF8String], -1, NULL);
        //1.5 执行查询操作
        int queryResult = sqlite3_step(querStmt);
        //1.6 释放资源
        sqlite3_finalize(querStmt);
        
        //2、如果数据存在 执行删除操作
        if (queryResult == SQLITE_ROW) {
            //2.1 创建删除 语句对象
            sqlite3_stmt *dletestmt = nil;
            //2.2 创建删除 SQL 语句
            NSString *deleteSqlStr = @"delete from books where name = ?";
            //2.3 执行预处理
            int result = sqlite3_prepare_v2(db, [deleteSqlStr UTF8String], -1, &dletestmt, NULL);
            //2.4 绑定数据
            sqlite3_bind_text(dletestmt, 1, [name UTF8String], -1, NULL);
            //2.5 执行删除的sql
            int deleteResult = sqlite3_step(dletestmt);
            //2.6 释放资源
            sqlite3_finalize(dletestmt);
            //3、关闭数据ylkd
            sqlite3_close(db);
            
            if (deleteResult==SQLITE_DONE) {
                NSLog(@"删除数据成功");
            } else {
                NSLog(@"删除数据失败");
            }
        } else {
            //关闭数据库
            sqlite3_close(db);
            
        }
    } else {
        
        NSLog(@"打开失败");
    }
}

+(void)updateBookModel:(BookModel *)bookModel{
    //1、打开数据库
    //1、获取数据库路径
    //1、获取数据库路径
    //获取Document 路径
    NSString *documentPaht = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //创建拼接数据库路径
    NSString *sqlitPath = [documentPaht stringByAppendingPathComponent:@"book.sqlite"];
    
    sqlite3 *db;
    int openResult = sqlite3_open([sqlitPath UTF8String], &db);
    if (openResult ==SQLITE_OK) {
        //打开成功
        //2、创建修改语句对象
        sqlite3_stmt *alertStmt;
        //3、创建SQL
        NSString *alertSql = @"update user set name = ? and author = ? and price = ? and path = ?   and filename = ? and description  = ? and catograyIdtext = ? where id = ?";
        //4、执行预处理
        int prepareResult =sqlite3_prepare(db, [alertSql UTF8String], -1, &alertStmt, NULL);
        if (prepareResult == SQLITE_OK) {
            //5、封装参数
            sqlite3_bind_text(alertStmt, 1, [bookModel.name UTF8String], -1, NULL);
            
            sqlite3_bind_text(alertStmt, 2, [bookModel.author UTF8String], -1, NULL);
            
            sqlite3_bind_text(alertStmt, 3, [bookModel.path UTF8String], -1, NULL);
            
            sqlite3_bind_text(alertStmt, 4, [bookModel.filename UTF8String], -1, NULL);
            
            sqlite3_bind_text(alertStmt, 5, [bookModel.description UTF8String], -1, NULL);
            
            sqlite3_bind_text(alertStmt, 6, [bookModel.catograyId UTF8String], -1, NULL);
            
            
            sqlite3_bind_text(alertStmt, 7, [bookModel.id UTF8String], -1, NULL);
            
            //6、执行sql
            int result = sqlite3_step(alertStmt);
            if (result == SQLITE_DONE) {
                
                NSLog(@"执行成功");
            } else {
                NSLog(@"执行失败");
            }
            //7、释放资源
            sqlite3_finalize(alertStmt);
            sqlite3_close(db);
        } else {
            //关闭
            sqlite3_close(db);
            NSLog(@"执行失败");
        }
    } else {
        //打开失败
        NSLog(@"执行失败");
    }
    NSLog(@"执行失败");
}

+(BOOL)insertBookModel:(BookModel *)bookModel{
    //打开数据库
    //1、获取数据库路径
    //1、获取数据库路径
    //获取Document 路径
    NSString *documentPaht = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //创建拼接数据库路径
    NSString *sqlitPath = [documentPaht stringByAppendingPathComponent:@"book.sqlite"];
    
    NSLog(@"databases path is %@",sqlitPath);
    sqlite3 *db;
    
    int opentResult =sqlite3_open([sqlitPath UTF8String], &db);
    if(opentResult==SQLITE_OK){
        
        
        
        NSString *quertString = @"select * from books where id = ?";
        //1.2 创建查询语句对象
        sqlite3_stmt *querStmt;
        //1.3 执行预处理
        sqlite3_prepare_v2(db, [quertString UTF8String], -1, &querStmt, NULL);
        //1.4 绑定数据
        sqlite3_bind_text(querStmt,1, [bookModel.id UTF8String], -1, NULL);
        //1.5 执行查询操作
        int queryResult = sqlite3_step(querStmt);
        //1.6 释放资源
        sqlite3_finalize(querStmt);
        
        //2、如果数据存在 执行修改操作
        if (queryResult == SQLITE_ROW) {
            [self updateBookModel:bookModel];
        }else{
            //新增操作
            
            //3、定义语句对象
            sqlite3_stmt *statement;
            
            //4、创建添加SQL语句
            char *sql = "INSERT INTO books(name,author,path,filename,description,catograyIdtext,id) VALUES(?, ?, ?, ?, ?, ?, ?);";
            //5、执行预处理
            int success2 = sqlite3_prepare_v2(db, sql, -1, &statement, NULL);
            if (success2 != SQLITE_OK) {
                NSLog(@"Error: failed to insert:testTable");
                sqlite3_close(db);
                //1
                if(success2== SQLITE_ERROR){
                    NSLog(@"SQL error or missing database)");
                }
                return NO;
            }
            //6、封装插入的数据
            //这里的数字1，2，3代表上面的第几个问号，这里将三个值绑定到三个绑定变量
            
            sqlite3_bind_text(statement, 1, [bookModel.name UTF8String], -1, NULL);
            
            sqlite3_bind_text(statement, 2, [bookModel.author UTF8String], -1, NULL);
            
            sqlite3_bind_text(statement, 3, [bookModel.path UTF8String], -1, NULL);
            
            sqlite3_bind_text(statement, 4, [bookModel.filename UTF8String], -1, NULL);
            
            sqlite3_bind_text(statement, 5, [bookModel.description UTF8String], -1, NULL);
            
            sqlite3_bind_text(statement, 6, [bookModel.catograyId UTF8String], -1, NULL);
            
            
            sqlite3_bind_text(statement, 7, [bookModel.id UTF8String], -1, NULL);
            
            
            //7、执行插入语句
            success2 = sqlite3_step(statement);
            //8、释放statement
            sqlite3_finalize(statement);
            
            //如果插入失败
            if (success2 == SQLITE_ERROR) {
                NSLog(@"Error: failed to insert into the database with message.");
                //关闭数据库
                sqlite3_close(db);
                return NO;
            }
        }
        
        
        
        // 9、关闭数据库
        sqlite3_close(db);
        return YES;
        
    }else{
        //打开失败
        sqlite3_close(db);
        NSAssert(NO, @"打开数据库失败");
        
        return NO;
    }
}

@end


