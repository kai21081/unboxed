//
//  DetailProductViewController.m
//  SearsApp
//
//  Created by Jisoo Hong on 2015. 7. 25..
//  Copyright (c) 2015년 Jung Kim. All rights reserved.
//

#import "DetailProductViewController.h"
#import "ImageFetchService.h"
#import "WKWebViewController.h"

@interface DetailProductViewController ()<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *productImgView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailViewHeightConstraint;
@property (strong, nonatomic) NSMutableArray *videos;
@property (nonatomic) CGPoint pointNow;
@property (nonatomic) float detailViewHeightConstraintConstant;

@end

@implementation DetailProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  self.detailViewHeightConstraintConstant = self.detailViewHeightConstraint.constant;
  
  self.name.text = self.selectedProduct.name;
  self.price.text = self.selectedProduct.price;
  [ImageFetchService fetchImageWithString:self.selectedProduct.imageURL size:self.productImgView.frame.size completionHandler:^(UIImage *image) {
    self.productImgView.image = image;
  }];
  
    // Do any additional setup after loading the view.
  
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
  cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
  return cell;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  self.pointNow = scrollView.contentOffset;
  //self.detailViewHeightConstraintConstant = self.detailViewHeightConstraint.constant;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//  if (scrollView.contentOffset.y>0 && scrollView.contentOffset.y < 125) {
//    float offsetDelta = scrollView.contentOffset.y - self.pointNow.y;
//    self.detailViewHeightConstraint.constant = self.detailViewHeightConstraintConstant - offsetDelta;
//    [self.view layoutIfNeeded];
//  }
//  
//  if (scrollView.contentOffset.y<self.pointNow.y) {
//    NSLog(@"down %f", scrollView.contentOffset.y);
//  } else if (scrollView.contentOffset.y>self.pointNow.y) {
//    NSLog(@"up %f", scrollView.contentOffset.y);
//  }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  if([segue.identifier isEqualToString:@"ShowWebVC"]){
    WKWebViewController *webVC = (WKWebViewController*)segue.destinationViewController;
    webVC.productURL = self.selectedProduct.productURL;
  }
}



@end
