//
//  PVSubViewState.h
//  PVPaperFlow
//


#import <Foundation/Foundation.h>
#import "PVPaperFlowSubViewController.h"

@interface PVSubViewState : NSObject

@property (nonatomic, readonly) CGRect frame;
@property (nonatomic, strong) PVPaperFlowSubViewController *context;

- (instancetype)initWithContext:(PVPaperFlowSubViewController *)context;


@property(nonatomic,assign)CGSize InitialContentSize;

@property(nonatomic,assign)CGPoint InitialOffset;

@property(nonatomic,assign)CGPoint startPoint;

- (void)handlePan:(UIPanGestureRecognizer *)recognizer;
- (void)handleTap:(UITapGestureRecognizer *)recognizer;

@end
