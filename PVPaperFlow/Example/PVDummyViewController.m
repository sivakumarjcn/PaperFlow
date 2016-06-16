//
//  PVDummyViewController.m
//  PVPaperFlow
//


#import "PVDummyViewController.h"

UIViewController*(^dummyViewController)(NSString*) = ^(NSString* title) {
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor colorWithHue:(arc4random() % 255 / 255.0) saturation:0.7 brightness:0.7 alpha:1.0];
    
    vc.title = title;
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = title;
    [lbl sizeToFit];
    lbl.frame = CGRectOffset(lbl.frame, 20, 20);
    [vc.view addSubview:lbl];
    
    return vc;
};

@interface PVDummyViewController ()

@end

@implementation PVDummyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSArray *)subViewControllers {
    NSArray *subVC = @[dummyViewController([NSString stringWithFormat:@"%@ - %@", self.title, @"subview 1"]),
                       dummyViewController([NSString stringWithFormat:@"%@ - %@", self.title, @"subview 2"]),
                       dummyViewController([NSString stringWithFormat:@"%@ - %@", self.title, @"subview 3"]),
                       dummyViewController([NSString stringWithFormat:@"%@ - %@", self.title, @"subview 4"]),
                       dummyViewController([NSString stringWithFormat:@"%@ - %@", self.title, @"subview 5"]),
                       dummyViewController([NSString stringWithFormat:@"%@ - %@", self.title, @"subview 6"])];
    
    return subVC;
}

@end
