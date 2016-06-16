//
//  PVPaperFlowViewController.m
//  PVPaperFlow
//


#import "PVPaperFlowViewController.h"
#import "PVPaperFlowView.h"
#import "PVPaperFlowProtocol.h"

#import "PVMainViewState.h"
#import "PVSubViewState.h"

@interface PVPaperFlowViewController ()

@property (nonatomic, strong) PVPaperFlowMainViewController *mainViewController;
@property (nonatomic, strong) PVPaperFlowSubViewController *subViewController;

@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) UIViewController *currentMainViewController;

@end

@implementation PVPaperFlowViewController

- (void)initialization {
    _mainViewController = [[PVPaperFlowMainViewController alloc] init];
    _mainViewController.delegate = self;
    
    _subViewController = [[PVPaperFlowSubViewController alloc] init];
    _subViewController.delegate = self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self initialization];

        _viewControllers = [NSMutableArray new];
    }
    return self;
}

- (id)initWithViewControllers:(NSArray *)viewControllers {
    self = [super init];
    if (self) {
        [self initialization];
        
        _viewControllers = [NSMutableArray arrayWithArray:viewControllers];
    }
    return self;
}

- (void)viewDidLoad {
    self.view.frame = [[UIScreen mainScreen] bounds];
}

- (void)setMainViewControllers:(NSArray *)viewControllers {
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSAssert([obj conformsToProtocol:@protocol(PVPaperFlowProtocol)], @"'%@' doesn't conform to the protocol 'AJPaperFlowProtocol'", NSStringFromClass([obj class]));
    }];
    
    [_mainViewController setViewControllers:viewControllers];
}

- (void)setSubViewControllers:(NSArray *)viewControllers {
    [_subViewController setViewControllers:viewControllers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.view addSubview:_mainViewController.view];
    [self.view addSubview:_subViewController.view];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self setMainViewControllers:_viewControllers];
    [self setSubViewControllers:((id<PVPaperFlowProtocol>)[_viewControllers firstObject]).subViewControllers];
}

#pragma mark - AJPaperFlowMainDelegate

- (void)ajPaperFlowMainViewControllerDidChangeCurrentViewController:(UIViewController *)currentViewController {

    if (_currentMainViewController != currentViewController) {
        _currentMainViewController = currentViewController;

        [self setSubViewControllers:((id<PVPaperFlowProtocol>)currentViewController).subViewControllers];
    }

    [_subViewController scrollToLeft];
}

- (void)ajPaperFlowMainViewController:(PVPaperFlowMainViewController *)controller didHandleTap:(UITapGestureRecognizer *)recognizer {

    // TODO
}

- (void)ajPaperFlowMainViewController:(PVPaperFlowMainViewController *)controller didHandlePan:(UIPanGestureRecognizer *)recognizer {

    // TODO
}

#pragma mark - AJPaperFlowSubDelegate

- (void)pvPaperFlowSubViewController:(PVPaperFlowSubViewController *)controller didHandleTap:(UITapGestureRecognizer *)recognizer {

    //[_mainViewController.state subViewDidHandleTap:recognizer];
}

- (void)pvPaperFlowSubViewController:(PVPaperFlowSubViewController *)controller didHandlePan:(UIPanGestureRecognizer *)recognizer {

    [_mainViewController.state subViewDidHandlePan:recognizer];

}

@end
