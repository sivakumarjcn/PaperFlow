//
//  PVSubViewFullScreenState.m
//  PVPaperFlow
//


#import "PVSubViewFullScreenState.h"
#import "PVSubViewDefaultState.h"
#import "PVSubViewHiddenState.h"
#import "PVPaperFlowView.h"

@implementation PVSubViewFullScreenState

- (CGRect)frame {
    CGRect f = self.context.view.superview.bounds;
    return f;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {

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
