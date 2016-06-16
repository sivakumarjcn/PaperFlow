//
//  PVMainViewState.m
//  PVPaperFlow
//


#import "PVMainViewState.h"

@implementation PVMainViewState

- (id)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-init is not a valid initializer. use initWithContext: instead"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initWithContext:(PVPaperFlowMainViewController *)context {
    self = [super init];
    if (self) {
        _context = context;
    }
    return self;
}

- (CGRect)frame {
    return CGRectZero;
}

- (CGSize)scale {
    return CGSizeMake(1.0, 1.0);
}

- (CGFloat)opacity {
    return 1.0;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    [self throwShouldOverrideExceptionInSelector:NSStringFromSelector(_cmd)];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    [self throwShouldOverrideExceptionInSelector:NSStringFromSelector(_cmd)];
}

#pragma mark -

- (void)subViewDidHandleTap:(UITapGestureRecognizer *)recognizer {
    [self throwShouldOverrideExceptionInSelector:NSStringFromSelector(_cmd)];
}

- (void)subViewDidHandlePan:(UIPanGestureRecognizer *)recognizer {
    [self throwShouldOverrideExceptionInSelector:NSStringFromSelector(_cmd)];
}

#pragma mark -

- (void)throwShouldOverrideExceptionInSelector:(NSString *)selector {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", selector]
                                 userInfo:nil];
}

@end
