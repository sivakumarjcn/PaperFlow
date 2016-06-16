//
//  PVSubViewHiddenState.m
//  PVPaperFlow
//


#import "PVSubViewHiddenState.h"
#import "PVSubViewDefaultState.h"
#import "PVSubViewFullScreenState.h"

#import "PVPaperFlowView.h"

@implementation PVSubViewHiddenState

- (CGRect)frame {
    
    PVPaperFlowView *view = (PVPaperFlowView *)self.context.view;
    CGRect originFrame = view.superview.bounds;
    CGRect f = originFrame;
    f.origin.y = (int)(CGRectGetHeight(originFrame) - (int)(CGRectGetHeight(f) * view.subViewsProportion/4));
    f.size.height = (int)(CGRectGetHeight(f) * view.subViewsProportion/4);
    
    return f;
}



- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    
    self.context.state = [[PVSubViewDefaultState alloc] initWithContext:self.context];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    static CGRect originalFrame;
    PVPaperFlowView *view = (PVPaperFlowView *)self.context.view;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        originalFrame = view.frame;
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:view];
        CGRect newFrame = originalFrame;
        
        
        newFrame.origin.y += translation.y;
        newFrame.size.height += (translation.y * -1);
        
        view.frame = newFrame;
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGFloat proportion = CGRectGetHeight(view.frame) / CGRectGetHeight(view.superview.frame);
        CGFloat midProportion = (1.0 + view.subViewsProportion)/2.0;
        
        if (proportion > midProportion) {
            
            self.context.state = [[PVSubViewFullScreenState alloc] initWithContext:self.context];
        } else {
            self.context.state = [[PVSubViewDefaultState alloc] initWithContext:self.context];
        }
    }
}

@end
