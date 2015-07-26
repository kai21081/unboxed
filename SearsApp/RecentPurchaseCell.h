//
//  RecentPurchaseCell.h
//  SearsApp
//
//  Created by Jisoo Hong on 2015. 7. 25..
//  Copyright (c) 2015년 Jung Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentPurchaseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *productImgView;
@property (weak, nonatomic) IBOutlet UILabel *dateOfPurchase;

@end
