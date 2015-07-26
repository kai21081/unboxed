//
//  SearsService.m
//  SearsApp
//
//  Created by Jung Kim on 7/21/15.
//  Copyright (c) 2015 Jung Kim. All rights reserved.
//

#import "SearsService.h"
#import "JSONParserService.h"

@interface SearsService()

@property (strong, nonatomic) NSString *apiKey;

@end

@implementation SearsService

+(SearsService*)sharedService{
  static SearsService *myService = nil;
  static dispatch_once_t once_token;
  dispatch_once(&once_token, ^{
    if (myService == nil){
      myService = [[SearsService alloc] init];
      myService.apiKey = @"BE3wLmkvcn5KtQJJ8PNHpYAKZ3ZBrftG";
    }
  });
  return myService;
}

//-(void)fetchProductsByKeyword:(NSString *)keyword completionHandler:(NSArray* (^)(NSData* data)) completionHandler {
//
//  NSString *keywordSearchURL = [NSString stringWithFormat:@"http://api.developer.sears.com/v2.1/products/search/Sears/json/keyword/%@?apikey=%@",keyword,self.apiKey];
//  NSURL *url = [NSURL URLWithString:keywordSearchURL];
//  NSURLRequest *request = [NSURLRequest requestWithURL:url];
//  [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//    
//  }]resume];
//}

-(void)fetchProductWithURL:(NSString *)urlString completionHandler:(void (^)(Product*, NSString*)) completionHandler{
  NSURL *url = [NSURL URLWithString:urlString];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if(error != nil){
      
    }else{
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
      switch (httpResponse.statusCode) {
        case 200:{
          Product *product = [JSONParserService parseJSONForProduct:data];
          dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(product, nil);
          });
          
        }
          break;
          
        default:
          break;
      }
    }

  }]resume];
  
  
}

@end
