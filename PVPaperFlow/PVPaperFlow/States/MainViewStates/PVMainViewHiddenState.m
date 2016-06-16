//
//  PVMainViewHiddenState.m
//  PVPaperFlow
//


#import "PVMainViewHiddenState.h"
#import "PVMainViewDefaultState.h"

#import "PVPaperFlowView.h"

@implementation PVMainViewHiddenState

- (CGRect)frame {
    return CGRectZero;
}

- (CGSize)scale {
    return CGSizeMake(0.9, 0.9);
}

- (CGFloat)opacity {
    return 0.3f;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    self.context.state = [[PVMainViewDefaultState alloc] initWithContext:self.context];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    // do nothing
}

#pragma mark -

- (void)subViewDidHandleTap:(UITapGestureRecognizer *)recognizer {
    // do nothing
}

- (void)subViewDidHandlePan:(UIPanGestureRecognizer *)recognizer {
    // TODO
}

@end
