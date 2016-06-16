//
//  PVPaperFlowMainViewController.h
//  PVPaperFlow
//


#import <UIKit/UIKit.h>

@class PVPaperFlowMainViewController;
@class PVMainViewState;

@protocol AJPaperFlowMainDelegate <NSObject>

@required
- (void)ajPaperFlowMainViewControllerDidChangeCurrentViewController:(UIViewController *)currentViewController;

- (void)ajPaperFlowMainViewController:(PVPaperFlowMainViewController *)controller didHandleTap:(UITapGestureRecognizer *)recognizer;
- (void)ajPaperFlowMainViewController:(PVPaperFlowMainViewController *)controller didHandlePan:(UIPanGestureRecognizer *)recognizer;
@end

@interface PVPaperFlowMainViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) id<AJPaperFlowMainDelegate> delegate;
@property (nonatomic, strong) PVMainViewState *state;

- (void)setViewControllers:(NSArray*)viewControllers;

@end
