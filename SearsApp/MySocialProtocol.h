//
//  MySocialProtocol.h
//  SearsApp
//
//  Created by Jisoo Hong on 2015. 7. 26..
//  Copyright (c) 2015년 Jung Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MySocialProtocol <NSObject>

@required
-(void)didTapTwitterButton:(UITableViewCell*)cell;
-(void)didTapFacebookButton:(UITableViewCell*)cell;
-(void)didTapEmailButton:(UITableViewCell*)cell;
@end
