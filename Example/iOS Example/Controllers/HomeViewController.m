
//
//  HomeViewController.m
//  iOS Example
//
//  Created by zhoushuai on 2019/5/10.
//

#import "HomeViewController.h"
@import AFNetworking;

@interface HomeViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation HomeViewController


#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self.view addSubview:self.button];
}



#pragma mark - Respond To Events
- (void)onBtnClick:(UIButton *)btn {
    [self requestData2];
//    [self requestData2];
 }


- (void)requestData1 {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"https://api.apiopen.top/getTangPoetry?page=1&count=20"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
}


- (void)requestData2 {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    NSString *urlString = @"https://api.apiopen.top/getTangPoetry?page=1&count=20";
    NSDictionary *params = @{@"name" : @"bang",
                             @"phone": @{@"mobile": @"xx", @"home": @"xx"},
                             @"families": @[@"father", @"mother"],
                             @"nums": [NSSet setWithObjects:@"1", @"2", nil]
                             };
    [manager GET:urlString parameters:params headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"ResponseObject：%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
 }


#pragma mark - Getter && Setter
- (UIButton *)button{
    if(_button == nil){
        CGFloat buttonWidth = CGRectGetWidth(self.view.frame) - 30 * 2;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, buttonWidth, 50)];
        [button setTitle:@"开始测试" forState:UIControlStateNormal];
        button.layer.cornerRadius = 25;
        button.layer.masksToBounds = YES;
        button.titleLabel.textColor = [UIColor whiteColor];
        button.backgroundColor = [UIColor purpleColor];
        [button addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _button = button;
    }
    return _button;
}


@end
