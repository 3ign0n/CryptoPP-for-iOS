//
//  CryptoppDemoHashViewController.m
//  Cryptopp-for-iOS
//
//  Created by TAKEDA hiroyuki(aka @3ign0n) on 11/12/23.
//

#import "CryptoppDemoHashViewController.h"
#import "CryptoppHash.h"

@interface CryptoppDemoHashViewController ()
@property (strong, nonatomic) UIPopoverController *mainPopoverController;
- (void)configureView;
@end

@implementation CryptoppDemoHashViewController

@synthesize detailItem = _detailItem;
@synthesize sgmtctrlHashType = _sgmtctrlHashType;
@synthesize sgmtctrlShaLength = _sgmtctrlShaLength;
@synthesize textFieldSrcText = _textFieldSrcText;
@synthesize buttonCalcurate = _buttonCalcurate;
@synthesize textViewHashResult = _textViewHashResult;
@synthesize mainPopoverController = _mainPopoverController;


#pragma mark - internal
+ (void)printData:(NSData*)data target:(UILabel*)target {
    
	NSMutableString *s = [NSMutableString string];
    const unsigned char * hashValue = [data bytes];
    
    int i;
    for (i = 0; i < [data length]; i++) {
        [s appendFormat:@"%02x", hashValue[i]];
    }
	target.text = s;
}



#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.mainPopoverController != nil) {
        [self.mainPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [self setSgmtctrlHashType:nil];
    [self setSgmtctrlShaLength:nil];
    [self setTextFieldSrcText:nil];
    [self setButtonCalcurate:nil];
    [self setTextViewHashResult:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Hash Functions", @"Hash Functions");
    }
    return self;
}
							
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Main", @"Main");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.mainPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.mainPopoverController = nil;
}

#pragma mark - events
typedef enum {
    CryptoppDemoHashViewHashTypeMd5,
    CryptoppDemoHashViewHashTypeSha,
} CryptoppDemoHashViewHashType;

- (IBAction)sgmtctrlHashTypeDidTap:(id)sender {
    int selectedIndex = [[self sgmtctrlHashType] selectedSegmentIndex];
    if (selectedIndex == CryptoppDemoHashViewHashTypeMd5) {
        [self sgmtctrlShaLength].hidden = YES;
    } else if (selectedIndex == CryptoppDemoHashViewHashTypeSha) {
        [self sgmtctrlShaLength].hidden = NO;
    }
}

- (IBAction)textFieldSrcTextDidEndOnExit:(id)sender {
    [sender resignFirstResponder];
}

CryptppSHALength shaLength[] = {
    CryptppSHALength1,
    CryptppSHALength256,
    CryptppSHALength512,
};

- (IBAction)buttonCalcurateDidTap:(id)sender {
    [[self textFieldSrcText] resignFirstResponder];

    NSData * srcData = [[self textFieldSrcText].text dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData * hashData = nil;
    int selectedIndexHashType = [[self sgmtctrlHashType] selectedSegmentIndex];
    if (selectedIndexHashType == CryptoppDemoHashViewHashTypeMd5) {
        CryptoppMD5 * md5 = [[CryptoppMD5 alloc] init];
        hashData = [md5 getHashValue:srcData];
    } else if (selectedIndexHashType == CryptoppDemoHashViewHashTypeSha) {
        int selectedIndexHashLength = [[self sgmtctrlShaLength] selectedSegmentIndex];
        
        CryptoppSHA * sha = [[CryptoppSHA alloc] initWithLength:shaLength[selectedIndexHashLength]];
        hashData = [sha getHashValue:srcData];
    }
    
    if (hashData != nil) {
        [CryptoppDemoHashViewController printData:hashData target:[self textViewHashResult]];
    }
}
@end
