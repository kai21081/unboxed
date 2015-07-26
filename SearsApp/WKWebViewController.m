//
//  WKWebViewController.m
//  SearsApp
//
//  Created by Jisoo Hong on 2015. 7. 26..
//  Copyright (c) 2015년 Jung Kim. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewController ()<WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;
@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.webView = [[WKWebView alloc]initWithFrame:self.view.frame];
  [self.webView setBackgroundColor:[UIColor whiteColor]];
  [self.view addSubview:self.webView];
  //self.webView.navigationDelegate = self;
  NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.productURL]];
  [self.webView loadRequest:request];
    // Do any additional setup after loading the view.
}

@end
