//
//  PVPaperFlowSubViewController.m
//  PVPaperFlow
//


#import "PVPaperFlowSubViewController.h"
#import "PVPaperFlowSubView.h"
#import "PVSubViewFullScreenState.h"

#import "PVSubViewDefaultState.h"

#import <POP/POP.h>

@interface PVPaperFlowSubViewController () {
    
    
}



@property (nonatomic, strong) PVPaperFlowSubView *v;

@property (nonatomic, strong) UIView *tappedSubview;

@end

@implementation PVPaperFlowSubViewController

- (void)loadView {
    _v = [[PVPaperFlowSubView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _v.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _v.scrollView.delegate = self;
    
    self.view = _v;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _state = [[PVSubViewDefaultState alloc] initWithContext:self];
    _v.frame = self.state.frame;
}

- (void)transitionToCurrentState {
    CGRect frame = _state.frame;
    
    POPSpringAnimation *frameAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    frameAnimation.toValue = [NSValue valueWithCGRect:frame];
    frameAnimation.springBounciness = 6.f;
    frameAnimation.delegate = self;
    [self.view pop_addAnimation:frameAnimation forKey:@"frameAnimation"];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    [_v removeViews];
    
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_v pushView:((UIViewController*)obj).view];
    }];
}

- (void)scrollToLeft {
    [_v.scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    [self.state handlePan:recognizer];

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        self.state.InitialContentSize = _v.scrollView.contentSize;
        
        self.state.startPoint = [recognizer locationInView:self.view];
        
        self.state.InitialOffset = _v.scrollView.contentOffset;
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        
        CGPoint trans = [recognizer translationInView:self.view];
        
        CGFloat factor = fabsf(_v.scrollView.contentSize.width/self.state.InitialContentSize.width);
        
        float diffx = (factor*self.state.InitialOffset.x) - trans.x;
        
        if (diffx > -50 && diffx < ( _v.scrollView.contentSize.width)-_v.scrollView.bounds.size.width) {
            [_v.scrollView setContentOffset:CGPointMake(diffx, _v.scrollView.contentOffset.y)];
        }
    }
    
    
    if ([_delegate respondsToSelector:@selector(pvPaperFlowSubViewController:didHandlePan:)]) {
        [_delegate pvPaperFlowSubViewController:self didHandlePan:recognizer];
    }
}


- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    
    self.state.InitialContentSize = _v.scrollView.contentSize;
    
    self.state.startPoint = [recognizer locationInView:self.view];
    
    self.state.InitialOffset = _v.scrollView.contentOffset;
    
    [self.state handleTap:recognizer];
    
    
    if ([_delegate respondsToSelector:@selector(pvPaperFlowSubViewController:didHandleTap:)]) {
        [_delegate pvPaperFlowSubViewController:self didHandleTap:recognizer];
    }
}

#pragma mark - Setter

- (void)setState:(PVSubViewState *)state {
    _state = state;
    
    
    if ([_state isKindOfClass:[PVSubViewFullScreenState class]]) {
        
        CGPoint offset = _v.scrollView.contentOffset;
        
        NSInteger pageWidth = _v.scrollView.contentSize.width/_v.numberOfViews;
        
        int mulitpe = roundf(offset.x/pageWidth);
        
        NSLog(@" remanin %d",mulitpe);
        
        NSLog(@"offset X %f",offset.x);
        
        offset.x= (mulitpe*_v.scrollView.frame.size.width);
        
        POPBasicAnimation *basicAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPScrollViewContentOffset];
        basicAnim.toValue = [NSValue valueWithCGPoint:offset];
        basicAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        [_v.scrollView pop_addAnimation:basicAnim forKey:@"offsetX"];
        
        [_v.scrollView setPagingEnabled:YES];
        
    }else {
        [_v.scrollView setPagingEnabled:NO];
    }
    
    [self transitionToCurrentState];
}

#pragma mark - POPAnimationDelegate




- (void)pop_animationDidApply:(POPAnimation *)anim {
    
    
    
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    
}

@end
