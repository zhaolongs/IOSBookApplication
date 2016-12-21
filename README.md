# IOSBookApplication

IOS方面的书籍浏览项目

###网络数据访问方面
ATS全称为App Transport Security，它是iOS9的一个新特性，旨在提高iOS设备与服务器交互的安全性。简单地说，ATS会阻止未注册的网络请求

```
//GET 方式加载数据
//数据格式为Array对象形的JSON数据
//服务数据地址
Nsstring *url = @"";
//构建URL 
NSURL *urlTo = [NSURL URLWithString :url];
//创建 请求对象 
NSURLRequest *request = [NSURLRequest requestWithURL:url];
//发送请求
[[[NSURLSession sharedSession] dataTaskWithRequet :request commpletionHandler:^(NSData *data,NSURLResponse * response,NSError * error){
//处理请求数据 
}] resume];
```
上述就是基本把一个地址上的数据加载回来了，在响应实体中对数据的处理 

```
//返回的数据类型是NSData 类型的
//这里返回的是 数组对象类型的，直接格式化为 NSArray数据
NSError *err = nil;
NSArray *array = [NSJSONSerialization JSONObjectWithData :data
                                        options:NSJSONReadingAllowFragments
                                        error :&err];
if(array!=nil&&err==nil){
    NSLog(@"数据解析成功");
    //处理数据 
    for(int i=0;i<array.count;i++){
        NSDictionary *dict = array[i];
        //转模型数据
        //BookModel的数据模型载体
        BookModel *model = [BookMocel bookModelWithDict: dict];
    }
}else{
    NSLog(@"数据解析失败");
}

```




