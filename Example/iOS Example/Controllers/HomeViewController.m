
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
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"https://www.apiopen.top/journalismApi"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
    
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
