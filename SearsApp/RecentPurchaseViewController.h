//
//  RecentPurchaseViewController.h
//  SearsApp
//
//  Created by Jung Kim on 7/25/15.
//  Copyright (c) 2015 Jung Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewsFeedDelegate.h"

@interface RecentPurchaseViewController : UIViewController
@property (weak, nonatomic) id<AddNewsFeedDelegate> delegate;
@end
