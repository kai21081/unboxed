//
//  JSONParserService.m
//  SearsApp
//
//  Created by Jung Kim on 7/21/15.
//  Copyright (c) 2015 Jung Kim. All rights reserved.
//

#import "JSONParserService.h"

@implementation JSONParserService

+(Product*)parseJSONForProduct:(NSData *)data{
//  NSMutableArray *products = [[NSMutableArray alloc]init];
  NSError *error;
  NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  NSDictionary *productObject = [[jsonObject objectForKey:@"ProductDetail"] objectForKey:@"SoftHardProductDetails"];
  NSDictionary *priceObj = [productObject objectForKey:@"Price"];
  NSString *price = [priceObj objectForKey:@"RegularPrice"];
  NSDictionary *productDescriptionObj = [productObject objectForKey:@"Description"];
  NSString *name = [productDescriptionObj objectForKey:@"DescriptionName"];
  name = [name stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"\'"];
  name = [name stringByReplacingOccurrencesOfString:@"&#8221;" withString:@"\""];
  NSDictionary *productImages = [productDescriptionObj objectForKey:@"Images"];
  NSString *imageURL = [productImages objectForKey:@"MainImageUrl"];
  Product *product = [[Product alloc]init];
  product.name  = name;
  product.imageURL = imageURL;
  product.price = price;
//  [products addObject:product];
  return product;
}
@end
