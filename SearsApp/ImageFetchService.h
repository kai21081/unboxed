//
//  ImageFetchService.h
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 19..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageFetchService : NSObject
+(void) fetchImageWithString:(NSString*)urlPath size:(CGSize)size completionHandler:(void(^)(UIImage*))completionHandler;
@end
