//
//  ViewController.m
//  SampleOneFingerZoom
//
//  Created by Sivakumar J on 9/9/14.
//  Copyright (c) 2014 Gensler. All rights reserved.
//

#import "ViewController.h"
//#import "UIScrollView+BDDRScrollViewAdditions.h"

@interface ViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate> {
    
    __weak IBOutlet UIScrollView *scrollView;
    
    UIView *zoomView;
}
@property (nonatomic, assign) BOOL scrollViewIsSetUpCompletly;

@property(nonatomic,strong)UIPanGestureRecognizer *pangesture;
@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
  
    scrollView.scrollEnabled = YES;
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    scrollView.delegate = self;
    scrollView.minimumZoomScale = 0.4;
    scrollView.maximumZoomScale = 1.0;
   
 
    CGSize viewSize = CGSizeMake(5000, scrollView.bounds.size.height);
    
    zoomView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, viewSize}];
    [scrollView addSubview:zoomView];
    scrollView.contentSize = viewSize;
    
    for (NSUInteger x = 0; x < 16; x++) {
        UIView *view = [[UIView alloc] initWithFrame:(CGRect){x * scrollView.bounds.size.width, 0, scrollView.bounds.size}];
        view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0f
                                               green:arc4random_uniform(255) / 255.0f
                                                blue:arc4random_uniform(255) / 255.0f
                                               alpha:1.0f];
        
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(50, 50, scrollView.bounds.size.width-100, scrollView.bounds.size.height-100)];
        [view addSubview:table];
        [zoomView addSubview:view];
        
    }

    self.pangesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panScrollView:)];
    [self.pangesture  setDelegate:self];
    [scrollView addGestureRecognizer:self.pangesture ];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.scrollViewIsSetUpCompletly) return;
    
    
    scrollView.zoomScale = scrollView.minimumZoomScale;
    self.scrollViewIsSetUpCompletly = YES;
}

#pragma mark - UIScrollViewDelegate Methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
 
    return zoomView;
}



    
-(void)panScrollView:(UIPanGestureRecognizer*)pan {
  
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
    }else if(pan.state == UIGestureRecognizerStateChanged) {
        
        CGPoint trans = [scrollView.panGestureRecognizer velocityInView:scrollView];
        
        //NSLog(@"trans %@",NSStringFromCGPoint(trans));
        
        CGFloat scaleValue = trans.y/(scrollView.bounds.size.height*15);
        
        NSLog(@"scale %f",scrollView.zoomScale);
        
       
        scrollView.zoomScale-=scaleValue;
        
    }else if(pan.state == UIGestureRecognizerStateEnded) {
        if (scrollView.zoomScale > 0.75 ) {
            [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                scrollView.zoomScale = 1.0;
            } completion:nil];
            
        }else  {
            [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                scrollView.zoomScale = 0.4;
            } completion:nil];
            
        }
        
       
        
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isEqual:self.pangesture] && [otherGestureRecognizer isEqual:scrollView.panGestureRecognizer]){
        return YES;
    }
    return NO;
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isEqual:self.pangesture]) {
        if (gestureRecognizer.numberOfTouches > 0) {
            CGPoint translation = [self.pangesture velocityInView:scrollView];
            return fabs(translation.y) > fabs(translation.x);
        } else {
            return NO;
        }
    }
    return YES;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView1
{
    UIView *subView = [scrollView.subviews objectAtIndex:0];
    
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentSize.height) * 1.0, 0.0);
    
    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
    
    if (scrollView.zoomScale == 1.0) {
        [scrollView setPagingEnabled:YES];
    }else {
        [scrollView setPagingEnabled:NO];
    }
}

@end
