//
//  HomeViewController.m
//  IosBookApplication2
//
//  Created by  androidlongs on 16/12/21.
//  Copyright © 2016年  androidlongs. All rights reserved.
//

#import "HomeViewController.h"
#import "BookListItemViewCell.h"
#import "DbManager.h"
#import "BookModel.h"

@interface HomeViewController ()<UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *headerSelectTable;

@property(nonatomic,strong) NSMutableArray *bookListArray;
@property(nonatomic,weak) UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航控制器的代理为self
    //self.navigationController.delegate = self;
    // Do any additional setup after loading the view.
    
    [_headerSelectTable addTarget:self action:@selector(selected:) forControlEvents:UIControlEventValueChanged];
    
    
    [self setViewFunction];
    
    [self loadLocationData];
    
}
//加载本地数据库数据
-(void) loadLocationData{
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        _bookListArray = [DbManager queryAllBookLst];
        //加载网络数据
         [self loadNetData];                       
    });
}
//加载网络数据
-(void) loadNetData {
    
    NSString *bookListUrl = @"http://192.168.0.102:10008/BookStoreProgret/moble/book/service?tag=getBookList";
    
    //创建URL
    NSURL *url = [NSURL URLWithString:bookListUrl];
    //创建Request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //发送请求
    [[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //处理响应结果
        NSString *responseString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"网络请求数据 %@",responseString);
        
        NSError *er = nil;
        
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingAllowFragments
                                                          error:&er];
        NSMutableArray *appArray=[NSMutableArray  array];
        if (jsonObject != nil && er == nil){
            NSLog(@"解析成功");
            for (int i =0; i<jsonObject.count; i++) {
                NSDictionary *dictionary = jsonObject[i];
                BookModel *bookModel = [BookModel bookModelWithDict:dictionary];
                [appArray addObject:bookModel];
            }
            self.bookListArray = appArray;
            //主线程更新UI显示数据
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
            NSLog(@"解析错误");
        }
        
        
        
    }] resume];
}
-(void) setViewFunction{
    UITableView *tableView = [[UITableView alloc]init];
    //设置frame
    tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-56);
    //设置数据源代理
    tableView.dataSource=self;
    
    tableView.delegate = self;
    
    //分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView = tableView;
    //添加到视图中
    [self.view addSubview:tableView];
}


//设置组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//设置每一组内的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bookListArray.count;
}
// indexPath  可以根据具体的某行显示不同的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 反回不同的高度
    return 80;
}
//每一组显示的具体的样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 1. 定义一个重用标识符
    static NSString *identifier = @"book";
    
    // 2. 到缓存池中去找cell，（根据重用标识符）
    BookListItemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    // 3. 进行判断， 如果找不到， 实例化新的cell
    if (nil == cell) {
        //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
        // 从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BookListItemViewCell" owner:nil options:nil] lastObject];
    }
    
    BookModel *bookModel =  self.bookListArray[indexPath.row];
    cell.bookModel = bookModel;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)selected:(id)sender{
    UISegmentedControl* control = (UISegmentedControl*)sender;
    
    switch (control.selectedSegmentIndex) {
        case 0:
            NSLog(@"书籍列表");
            break;
        case 1:
            //
            NSLog(@"分类 列表");
            break;
            
        default:
            break;
    }
}
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
