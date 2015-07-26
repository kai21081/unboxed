//
//  ImageFetchService.m
//  StackOverFlowClient
//
//  Created by Jisoo Hong on 2015. 5. 19..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

//class ImageFetchService {
//  
//  let imageQueue = NSOperationQueue()
//  
//  func fetchImage(url : String, size: CGSize, completionHandler : (UIImage?) ->(Void)){
//    
//    self.imageQueue.addOperationWithBlock{ () -> Void in
//      if let data = NSData(contentsOfURL: NSURL(string: url)!){
//        let image = UIImage(data: data)
//        let imageThumbnail = ImageResizer.resizeImage(image!, size: size)
//        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//          completionHandler(imageThumbnail)
//        })
//        
//      }
//    }
//  }
//  }

#import "ImageFetchService.h"
#import "ImageResizer.h"

@implementation ImageFetchService

+(void) fetchImageWithString:(NSString*)urlPath size:(CGSize)size completionHandler:(void(^)(UIImage*))completionHandler{
  dispatch_queue_t imageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_async(imageQueue, ^{
    NSURL *url = [NSURL URLWithString:urlPath];
    NSData *data = [[NSData alloc]initWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    UIImage *imageThumbnail = [ImageResizer resizeImageFromOriginalImage:image size:size];
    dispatch_async(dispatch_get_main_queue(), ^{
      completionHandler(imageThumbnail);
    });
  });
}

@end
