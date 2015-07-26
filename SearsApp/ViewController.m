//
//  ViewController.m
//  SearsApp
//
//  Created by Jung Kim on 7/21/15.
//  Copyright (c) 2015 Jung Kim. All rights reserved.
//

#import "ViewController.h"
#import "ProductCell.h"
#import "SearsService.h"
#import "NewsFeedCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "ImageResizer.h"
#import "Product.h"
#import "DetailProductViewController.h"
#import "RecentPurchaseViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *newsFeeds;
@property (strong, nonatomic) MPMoviePlayerController *mc;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  NSString *newsFeedURL = [[NSBundle mainBundle]pathForResource:@"newsfeed" ofType:@"plist"];
  self.newsFeeds = [NSMutableArray arrayWithContentsOfFile:newsFeedURL];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  // Do any additional setup after loading the view, typically from a nib.
}

-(void)playVideo:(NSIndexPath*)indexPath{
  NewsFeedCell *cell = (NewsFeedCell*)[self.tableView cellForRowAtIndexPath:indexPath];
  NSDictionary *newsFeed = [self.newsFeeds objectAtIndex:indexPath.row];
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

#pragma mark - UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  NewsFeedCell *cell = (NewsFeedCell*)[tableView dequeueReusableCellWithIdentifier:@"NewsFeedCell"];
  NSDictionary *newsFeed = [self.newsFeeds objectAtIndex:indexPath.row];
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
  cell.contentView.layer.cornerRadius = 5;
  cell.contentView.layer.masksToBounds = YES;
//  if (indexPath.row == 0) {
//    cell.firstFrameView.alpha = 0;
//  MPMoviePlayerController *controller = [[MPMoviePlayerController alloc]
//                                         initWithContentURL:url];
//  
//  self.mc = controller; //Super important
//  self.mc.shouldAutoplay = NO;
//  [self.mc prepareToPlay];
//  self.mc.view.frame = cell.videoView.bounds; //Set the size
//  self.mc.controlStyle = MPMovieControlStyleNone;
//  self.mc.scalingMode = MPMovieScalingModeAspectFill;
//  self.mc.repeatMode = MPMovieRepeatModeOne;
//  [cell.videoView addSubview:self.mc.view]; //Show the view
//  [self.mc play]; //Start playing
//  }


  
  
  return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.newsFeeds.count;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  NSDictionary *selectedProduct = [self.newsFeeds objectAtIndex:indexPath.row];
  [[SearsService sharedService]fetchProductWithURL:[selectedProduct objectForKey:@"reqURL"] completionHandler:^(Product *product, NSString *error) {
    DetailProductViewController *detailProductVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailProductVC"];
    detailProductVC.selectedProduct = product;
    [self.mc stop];
    [self.navigationController pushViewController:detailProductVC animated:YES];
  }];
 }

-(void)addNewFeed:(NSDictionary *)newObject{
  [self.newsFeeds insertObject:newObject atIndex:0];
  [self.tableView reloadData];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  if([segue.identifier isEqualToString:@"ShowRecentPurchaseVC"]){
    [self.mc stop];
    RecentPurchaseViewController *recentPurchaseVC = (RecentPurchaseViewController*)segue.destinationViewController;
    recentPurchaseVC.delegate = self;
  }
}

@end
