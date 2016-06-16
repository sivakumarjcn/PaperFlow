//
//  PVSubViewDefaultState.m
//  PVPaperFlow
//


#import "PVSubViewDefaultState.h"
#import "PVSubViewFullScreenState.h"
#import "PVSubViewHiddenState.h"

#import "PVPaperFlowView.h"

@implementation PVSubViewDefaultState

- (CGRect)frame {
    PVPaperFlowView *view = (PVPaperFlowView *)self.context.view;

    CGRect originFrame = view.superview.bounds;
    CGRect f = originFrame;
    f.origin.y = (int)(CGRectGetHeight(originFrame) - (CGRectGetHeight(originFrame) * view.subViewsProportion));
    f.size.height = (int)(CGRectGetHeight(f) * view.subViewsProportion);

    return f;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    
    self.context.state = [[PVSubViewFullScreenState alloc] initWithContext:self.context];
    
    // TODO: scroll to view
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

        CGFloat lowProportion = (1.0+ view.subViewsProportion)/3.0;
        
        NSLog(@"prop %f mid %f low %f",proportion,midProportion,lowProportion);
        
        
        if (proportion > lowProportion && proportion > midProportion) {
            
            self.context.state = [[PVSubViewFullScreenState alloc] initWithContext:self.context];
        } else if( proportion  > lowProportion && proportion < midProportion) {
            self.context.state = [[PVSubViewDefaultState alloc] initWithContext:self.context];
        }else {
            self.context.state = [[PVSubViewHiddenState alloc] initWithContext:self.context];
        }
    }
}

@end
