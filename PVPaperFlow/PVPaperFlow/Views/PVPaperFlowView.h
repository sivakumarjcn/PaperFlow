//
//  PVPaperFlowView.h
//  PVPaperFlow
//


#import <UIKit/UIKit.h>

#define kOverlap 20.0f

@interface PVPaperFlowView : UIView {
    NSMutableArray *_views;
}

@property (nonatomic, assign) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat subViewsProportion UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIScrollView *scrollView;

-(NSInteger)numberOfViews;

- (void)removeViews;

@end
