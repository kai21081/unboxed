//
//  Product.h
//  SearsApp
//
//  Created by Jung Kim on 7/21/15.
//  Copyright (c) 2015 Jung Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Product : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *price;

@end
