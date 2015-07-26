//
//  JSONParserService.h
//  SearsApp
//
//  Created by Jung Kim on 7/21/15.
//  Copyright (c) 2015 Jung Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface JSONParserService : NSObject

+(Product*)parseJSONForProduct:(NSData *)data;
@end
