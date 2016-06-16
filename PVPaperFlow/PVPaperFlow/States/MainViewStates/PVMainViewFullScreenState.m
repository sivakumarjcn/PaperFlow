//
//  PVMainViewFullScreenState.m
//  PVPaperFlow
//


#import "PVMainViewFullScreenState.h"
#import "PVMainViewDefaultState.h"

@implementation PVMainViewFullScreenState

- (CGRect)frame {
    return self.context.view.superview.bounds;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    self.context.state = [[PVMainViewDefaultState alloc] initWithContext:self.context];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    // TODO
}

#pragma mark -

- (void)subViewDidHandleTap:(UITapGestureRecognizer *)recognizer {
    self.context.state = [[PVMainViewDefaultState alloc] initWithContext:self.context];
}

- (void)subViewDidHandlePan:(UIPanGestureRecognizer *)recognizer {
    // TODO
}

@end
