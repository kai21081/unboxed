//
//  NewsFeedCell.h
//  SearsApp
//
//  Created by Jung Kim on 7/24/15.
//  Copyright (c) 2015 Jung Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MySocialProtocol.h"

@interface NewsFeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UIImageView *firstFrameView;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *datePosted;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIView *socialView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel
;
@property (weak, nonatomic) IBOutlet UILabel *viewCount;

@property (weak, nonatomic) id<MySocialProtocol> delegate;


@end
