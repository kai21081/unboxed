//
//  RecentPurchaseViewController.m
//  SearsApp
//
//  Created by Jung Kim on 7/25/15.
//  Copyright (c) 2015 Jung Kim. All rights reserved.
//

#import "RecentPurchaseViewController.h"
#import "RecentPurchaseCell.h"
#import "ImageFetchService.h"
#import "VideoRecordingViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface RecentPurchaseViewController ()<UITableViewDataSource,UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSArray *purchases;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *selectedItem;

@end

@implementation RecentPurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  NSString *purchasePath = [[NSBundle mainBundle] pathForResource:@"RecentPurchase" ofType:@"plist"];
  self.purchases = [NSArray arrayWithContentsOfFile:purchasePath];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.purchases.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  RecentPurchaseCell *cell = (RecentPurchaseCell*)[tableView dequeueReusableCellWithIdentifier:@"RecentPurchaseCell"];
  NSDictionary *recentPurchase = [self.purchases objectAtIndex:indexPath.row];
  cell.name.text = [recentPurchase objectForKey:@"Name"];
  NSString *imgURL = [recentPurchase objectForKey:@"ImgURL"];
  cell.productImgView.image = nil;
  if (cell.productImgView.image == nil) {
    [ImageFetchService fetchImageWithString:imgURL size:CGSizeMake(100, 100) completionHandler:^(UIImage *thumbnailImage) {
      cell.productImgView.image = thumbnailImage;
    }];
  }
  NSDate *date = [recentPurchase objectForKey:@"DateOfPurchase"];
  NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
  formatter.dateFormat = @"MM/dd/yyyy";
  cell.dateOfPurchase.text = [formatter stringFromDate:date];
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  if ([UIImagePickerController
       isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    NSArray *availableMediaTypes = [UIImagePickerController
                                    availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    if ([availableMediaTypes containsObject:(NSString*)kUTTypeMovie]) {
      UIImagePickerController *camera = [[UIImagePickerController alloc]init];
      camera.sourceType = UIImagePickerControllerSourceTypeCamera;
      camera.mediaTypes = @[(NSString *)kUTTypeMovie];
      camera.delegate = self;
      self.selectedItem = [self.purchases objectAtIndex:indexPath.row];
      
      [self presentViewController:camera animated:true completion:^{
        
      }];
    }
  }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

  NSMutableDictionary *newFeed = [[NSMutableDictionary alloc]init];
  NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
  NSString *name = [self.selectedItem objectForKey:@"Name"];
  [newFeed setObject:name forKey:@"Name"];
  NSString *reqURL = @"http://api.developer.sears.com/v2.1/products/details/Sears/json/004V001177937001P?showSpec=false&apikey=BE3wLmkvcn5KtQJJ8PNHpYAKZ3ZBrftG";
  [newFeed setObject:reqURL forKey:@"reqURL"];
  [newFeed setObject:videoURL forKey:@"VideoURL"];
  [self.delegate addNewFeed:newFeed];
  [self dismissViewControllerAnimated:YES completion:^{
    
  }];
}

@end
