//
//  PVMainViewDefaultState.m
//  PVPaperFlow
//


#import "PVMainViewDefaultState.h"
#import "PVMainViewFullScreenState.h"
#import "PVMainViewHiddenState.h"

#import "PVPaperFlowView.h"

@implementation PVMainViewDefaultState

- (CGRect)frame {
    PVPaperFlowView *view = (PVPaperFlowView *)self.context.view;

    CGRect originFrame = view.superview.bounds;
    CGRect f = originFrame;
    //f.size.height = (int)(CGRectGetHeight(originFrame) * (1.0 - view.subViewsProportion) + kOverlap);

    return f;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    self.context.state = [[PVMainViewFullScreenState alloc] initWithContext:self.context];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    // do nothing
}

#pragma mark -

- (void)subViewDidHandleTap:(UITapGestureRecognizer *)recognizer {
    self.context.state = [[PVMainViewHiddenState alloc] initWithContext:self.context];
}

- (void)subViewDidHandlePan:(UIPanGestureRecognizer *)recognizer {
    // TODO
}


@end
