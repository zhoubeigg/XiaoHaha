//
//  FunnyImageViewController.m
//  XiaoHaha
//
//  Created by macAir on 15/9/17.
//  Copyright (c) 2015年 ZhouBei. All rights reserved.
//

#import "FunnyImageViewController.h"
#import "JokeCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "Joke.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"

@interface FunnyImageViewController ()
@property(nonatomic, strong) NSMutableArray *jokes;
@end

@implementation FunnyImageViewController

- (NSMutableArray *)jokes
{
    if (!_jokes) {
        self.jokes = [NSMutableArray array];
    }
    return _jokes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片笑话";
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
    self.tableView.backgroundColor = [UIColor grayColor];
    
    [MBProgressHUD showMessage:@"正在加载..." toView:self.tableView];
    
    [self loadJokes];
    
    [self setupUpRefresh];
}

- (void)setupUpRefresh
{
    [self.tableView addFooterWithTarget:self action:@selector(loadJokes)];
}

- (void)loadJokes
{
    static NSUInteger page = 0;
    NSString *httpUrl = @"http://apis.baidu.com/showapi_open_bus/showapi_joke/joke_pic";
    NSString *httpArg = [NSString stringWithFormat:@"page=%lu", (unsigned long)++page];
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 30];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"a86678ba0bfe00d5954d5561e42a8813" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   [MBProgressHUD hideHUDForView:self.tableView];
                                   [MBProgressHUD showMessage:@"请检查网络!" toView:self.tableView];
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, (long)error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                   NSDictionary *dictIn = dict[@"showapi_res_body"];
                                   if (dictIn) {
                                       NSArray *newJokes = [Joke objectArrayWithKeyValuesArray:dictIn[@"contentlist"]];
                                       [self.jokes addObjectsFromArray:newJokes];
                                       
                                       [self.tableView reloadData];
                                       [self.tableView footerEndRefreshing];
                                       
                                       [MBProgressHUD hideHUDForView:self.tableView];
                                       
                                       NSLog(@"HttpResponseCode:%ld page:%i", (long)responseCode, page);
                                   } else {
                                       [MBProgressHUD hideHUDForView:self.tableView];
                                       [MBProgressHUD showMessage:@"加载数据失败!" toView:self.tableView];
                                   }
                               }
                           }];

}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.jokes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获得cell
    JokeCell *cell = [JokeCell cellWithTableView:tableView];
    
    // 给cell传递模型数据
    cell.joke = self.jokes[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 400.0;
    return cellHeight;
}

@end
