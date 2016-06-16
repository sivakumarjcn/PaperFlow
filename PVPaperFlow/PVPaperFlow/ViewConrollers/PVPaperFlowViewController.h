//
//  PVPaperFlowViewController.h
//  PVPaperFlow
//


#import <UIKit/UIKit.h>

#import "PVPaperFlowMainViewController.h"
#import "PVPaperFlowSubViewController.h"

@interface PVPaperFlowViewController : UIViewController <AJPaperFlowMainDelegate, PVPaperFlowSubDelegate>

- (id)initWithViewControllers:(NSArray *)viewControllers;

@end
