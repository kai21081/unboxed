//
//  ImageResizer.h
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 19..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageResizer : NSObject
+(UIImage*) resizeImageFromOriginalImage:(UIImage*)image size:(CGSize)size;
@end
