//
//  CryptoppDemoDetailViewController.h
//  Cryptopp-for-iOS
//
//  Created by TAKEDA hiroyuki on 11/12/23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CryptoppDemoDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
