//
//  ImageResizer.m
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 19..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

#import "ImageResizer.h"

@implementation ImageResizer

+(UIImage*) resizeImageFromOriginalImage:(UIImage*)image size:(CGSize)size{
  UIGraphicsBeginImageContext(size);
  [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}
@end
