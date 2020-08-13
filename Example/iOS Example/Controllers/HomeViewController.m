
//
//  HomeViewController.m
//  iOS Example
//
//  Created by zhoushuai on 2019/5/10.
//

#import "HomeViewController.h"
#import "NSDictionary+LogHelper.h"

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
    //    [[self requestWithSystemMethod];
    //    [self requestWithAFMethod];
    [self requestWithAFHTTPSMethod];
}


- (void)requestWithSystemMethod {
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


- (void)requestWithAFMethod {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    NSString *urlString = @"http://php.weather.sina.com.cn/iframe/index/w_cl.php";
    NSDictionary *params = @{@"code": @"js",
                             @"dat": @"0",
                             @"dfc":@"1",
                             @"charset":@"utf-8"
    };
    [manager GET:urlString parameters:params headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"ResponseObject：%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}


- (void)requestWithAFHTTPSMethod {
    //使用服务器自签名证书，需要指定baseUrl属性。
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://localhost:443"]];
    
    //AFSSLPinningModeCertificate表示使用自签名证书
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //为了测试方便不验证域名，若要验证域名，则请求时的域名要和创建证书（创建证书的脚本执行时可指定域名）时的域名一致
    policy.validatesDomainName = YES;
    //自签名服务器证书需要设置allowInvalidCertificates为YES
    policy.allowInvalidCertificates = YES;
    //指定本地证书路径
    policy.pinnedCertificates = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
    manager.securityPolicy = policy;
    
    //访问本地建议HTTPS服务器
    [manager GET:@"https://localhost:443/"  parameters:nil
         headers:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"AF—HTTPS-success-response = [%@]", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"AF—HTTPS-Fail");
    }];
}





#pragma mark - Setter Method

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
