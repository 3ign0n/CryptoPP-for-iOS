//
//  CryptoppDemoHashViewController.h
//  Cryptopp-for-iOS
//
//  Created by TAKEDA hiroyuki(aka @3ign0n) on 11/12/23.
//

#import <UIKit/UIKit.h>

@interface CryptoppDemoHashViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmtctrlHashType;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmtctrlShaLength;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSrcText;
@property (weak, nonatomic) IBOutlet UIButton *buttonCalcurate;
@property (weak, nonatomic) IBOutlet UITextView *textViewHashResult;

@end
