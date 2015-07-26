//
//  NewsFeedCell.h
//  SearsApp
//
//  Created by Jung Kim on 7/24/15.
//  Copyright (c) 2015 Jung Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsFeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UIImageView *firstFrameView
;

@end
