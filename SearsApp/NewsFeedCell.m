//
//  NewsFeedCell.m
//  SearsApp
//
//  Created by Jung Kim on 7/24/15.
//  Copyright (c) 2015 Jung Kim. All rights reserved.
//

#import "NewsFeedCell.h"
#import <Social/Social.h>

@implementation NewsFeedCell

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)tweeterButtonPressed:(id)sender {
  
  [self.delegate didTapTwitterButton:self];
  
}
- (IBAction)facebookButtonPressed:(id)sender {
  [self.delegate didTapFacebookButton:self];
}
- (IBAction)emailButtonPressed:(id)sender {
  [self.delegate didTapEmailButton:self];
}

@end
