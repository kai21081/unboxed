//
//  VideoRecordingViewController.m
//  SearsApp
//
//  Created by Jisoo Hong on 2015. 7. 25..
//  Copyright (c) 2015년 Jung Kim. All rights reserved.
//

#import "VideoRecordingViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface VideoRecordingViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *camera;
@end

@implementation VideoRecordingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  if ([UIImagePickerController
       isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    NSArray *availableMediaTypes = [UIImagePickerController
                                    availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    if ([availableMediaTypes containsObject:(NSString*)kUTTypeMovie]) {
      self.camera = [UIImagePickerController new];
      self.camera.sourceType = UIImagePickerControllerSourceTypeCamera;
      self.camera.mediaTypes = @[(NSString *)kUTTypeMovie];
      self.camera.delegate = self;
    }
  }
}

@end
