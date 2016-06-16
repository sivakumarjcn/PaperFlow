//
//  PVMainViewState.h
//  PVPaperFlow
//


#import <Foundation/Foundation.h>
#import "PVPaperFlowMainViewController.h"

@interface PVMainViewState : NSObject

@property (nonatomic, readonly) CGRect frame;
@property (nonatomic, readonly) CGSize scale;
@property (nonatomic, readonly) CGFloat opacity;

@property (nonatomic, strong) PVPaperFlowMainViewController *context;

- (instancetype)initWithContext:(PVPaperFlowMainViewController *)context;

- (void)handleTap:(UITapGestureRecognizer *)recognizer;
- (void)handlePan:(UIPanGestureRecognizer *)recognizer;

- (void)subViewDidHandleTap:(UITapGestureRecognizer *)recognizer;
- (void)subViewDidHandlePan:(UIPanGestureRecognizer *)recognizer;

@end
