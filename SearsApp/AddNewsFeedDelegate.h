//
//  AddNewsFeedDelegate.h
//  SearsApp
//
//  Created by Jisoo Hong on 2015. 7. 25..
//  Copyright (c) 2015년 Jung Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddNewsFeedDelegate <NSObject>

@required
-(void)addNewFeed:(NSDictionary*)newObject;

@end
