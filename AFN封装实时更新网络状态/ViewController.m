//
//  ViewController.m
//  AFN封装实时更新网络状态
//
//  Created by 纵昂 on 2017/2/24.
//  Copyright © 2017年 纵昂. All rights reserved.
//

#import "ViewController.h"
#import "LGReachability.h"
#import "SVProgressHUD.h"
@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) NSString * status;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    真机测试时在同一个页面测试不同的网络状态
    [LGReachability LGwithSuccessBlock:^(NSString *status) {
        
        NSLog(@"网络状态%@",status);
        self.status = status;
        
        if ([status isEqualToString:@"无连接"]) {
            
            NSString *path = [[NSBundle mainBundle]pathForResource:@"404/error.html" ofType:nil];
            NSURL *url = [NSURL fileURLWithPath:path];
            NSURLRequest *requset = [NSURLRequest requestWithURL:url];
            [self.webView loadRequest:requset];
            
        } else if ([status isEqualToString:@"3G/4G网络"]){
            
            NSURL *url = [NSURL URLWithString:@"http://www.163.com//"];
            [self.webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0f]];
            
        }else if ([status isEqualToString:@"wifi状态下"]){
            
            NSURL *url = [NSURL URLWithString:@"http://www.163.com//"];
            [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
            
        }
        
    }] ;
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    //    [SVProgressHUD show];
    [SVProgressHUD showInfoWithStatus:self.status];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
