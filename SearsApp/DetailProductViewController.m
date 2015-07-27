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
#import "NewsFeedCell.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "ImageResizer.h"

@interface DetailProductViewController ()<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *productImgView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *shortDescription;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailViewHeightConstraint;
@property (strong, nonatomic) NSArray *otherVideos;
@property (nonatomic) CGPoint pointNow;
@property (nonatomic) float detailViewHeightConstraintConstant;
@property (strong, nonatomic) MPMoviePlayerController *mc;

@end

@implementation DetailProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"videoList" ofType:@"plist"];
  NSDictionary *allVideoDict = [NSDictionary dictionaryWithContentsOfFile:videoPath];
  self.otherVideos = [allVideoDict objectForKey:self.selectedProduct.category];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  self.detailViewHeightConstraintConstant = self.detailViewHeightConstraint.constant;
  
  self.name.text = self.selectedProduct.name;
  self.price.text = [NSString stringWithFormat:@"$%@",self.selectedProduct.price];
  self.shortDescription.text = self.selectedProduct.shortDescription;
  [ImageFetchService fetchImageWithString:self.selectedProduct.imageURL size:self.productImgView.frame.size completionHandler:^(UIImage *image) {
    self.productImgView.image = image;
  }];
  
    // Do any additional setup after loading the view.
  
}

-(void)playVideo:(NSIndexPath*)indexPath{
  NewsFeedCell *cell = (NewsFeedCell*)[self.tableView cellForRowAtIndexPath:indexPath];
  NSDictionary *newsFeed = [self.otherVideos objectAtIndex:indexPath.row];
  NSURL *url = nil;
  NSString *vidName = [newsFeed objectForKey:@"Video"];
  if (vidName) {
    NSString *vidPath = [[NSBundle mainBundle]pathForResource:vidName ofType:@"mp4"];
    url = [NSURL fileURLWithPath:vidPath];
  }else{
    url = [newsFeed objectForKey:@"VideoURL"];
  }
  MPMoviePlayerController *controller = [[MPMoviePlayerController alloc]
                                         initWithContentURL:url];
  cell.firstFrameView.alpha = 0;
  self.mc = controller; //Super important
  self.mc.shouldAutoplay = NO;
  [self.mc prepareToPlay];
  self.mc.view.frame = cell.videoView.bounds; //Set the size
  self.mc.controlStyle = MPMovieControlStyleNone;
  self.mc.scalingMode = MPMovieScalingModeAspectFill;
  self.mc.repeatMode = MPMovieRepeatModeOne;
  [cell.videoView addSubview:self.mc.view]; //Show the view
  [self.mc play]; //Start playing
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.otherVideos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  NewsFeedCell *cell = (NewsFeedCell*)[tableView dequeueReusableCellWithIdentifier:@"NewsFeedCell" forIndexPath:indexPath];
  NSDictionary *newsFeed = [self.otherVideos objectAtIndex:indexPath.row];
  cell.title.text = [newsFeed objectForKey:@"Name"];
  
  NSURL *url = nil;
  NSString *vidName = [newsFeed objectForKey:@"Video"];
  if (vidName) {
    NSString *vidPath = [[NSBundle mainBundle]pathForResource:vidName ofType:@"mp4"];
    url = [NSURL fileURLWithPath:vidPath];
  }else{
    url = [newsFeed objectForKey:@"VideoURL"];
  }
  
  
  AVURLAsset *asset1 = [[AVURLAsset alloc] initWithURL:url options:nil];
  AVAssetImageGenerator *generate1 = [[AVAssetImageGenerator alloc] initWithAsset:asset1];
  generate1.appliesPreferredTrackTransform = YES;
  NSError *err = NULL;
  CMTime time = CMTimeMake(7, 8);
  CGImageRef oneRef = [generate1 copyCGImageAtTime:time actualTime:NULL error:&err];
  UIImage *one = [[UIImage alloc] initWithCGImage:oneRef];
  
  [cell.firstFrameView setImage:[ImageResizer resizeImageFromOriginalImage:one size:cell.firstFrameView.bounds.size]];
  cell.firstFrameView.contentMode = UIViewContentModeScaleToFill;
  cell.firstFrameView.alpha = 1;
  
  cell.userIcon.image = [UIImage imageNamed:[newsFeed objectForKey:@"userIcon"]];
  cell.userIcon.backgroundColor = [UIColor blackColor];
  cell.userIcon.layer.cornerRadius = cell.userIcon.frame.size.width/2;
//  cell.delegate = self;
  cell.cardView.layer.cornerRadius = 10;
  cell.socialView.layer.cornerRadius = 10;
  
  cell.captionLabel.text = [newsFeed objectForKey:@"caption"];
  cell.viewCount.text = [NSString stringWithFormat:@"%@ views",[newsFeed objectForKey:@"viewCount"]];
  
  //  if (indexPath.row == 0){
  //    [self playVideo:indexPath];
  //  }
  return cell;

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  if (!decelerate) {
    [self scrollingFinish];
  }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  [self scrollingFinish];
}
- (void)scrollingFinish {
  //enter code here
  NSArray *indexes = [self.tableView indexPathsForVisibleRows];
  for (int i = 0; i < indexes.count; i++) {
    NSIndexPath *indexPath = (NSIndexPath*)indexes[i];
    NewsFeedCell *cell = (NewsFeedCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    CGRect cellRect = [self.tableView convertRect:cell.frame toView:self.tableView.superview];
    if(CGRectContainsRect(self.tableView.frame, cellRect)){
      [self.mc stop];
      [self playVideo:indexPath];
    };
  }
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
