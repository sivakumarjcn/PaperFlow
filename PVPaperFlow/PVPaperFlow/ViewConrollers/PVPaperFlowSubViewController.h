//
//  PVPaperFlowSubViewController.h
//  PVPaperFlow
//


#import <UIKit/UIKit.h>

@class PVPaperFlowSubViewController;
@class PVSubViewState;

@protocol PVPaperFlowSubDelegate <NSObject>

@required
- (void)pvPaperFlowSubViewController:(PVPaperFlowSubViewController *)controller didHandleTap:(UITapGestureRecognizer *)recognizer;
- (void)pvPaperFlowSubViewController:(PVPaperFlowSubViewController *)controller didHandlePan:(UIPanGestureRecognizer *)recognizer;

@end

@interface PVPaperFlowSubViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) id<PVPaperFlowSubDelegate> delegate;
@property (nonatomic, strong) PVSubViewState *state;



- (void)setViewControllers:(NSArray*)viewControllers;
- (void)scrollToLeft;

@end