//
//  HxPageViewController.m
//  HxPageViewController
//
//  Created by Harry Xiao Han on 2014-06-11.
//  Copyright (c) 2014 Harry Han. All rights reserved.
//

#import "HxPageViewController.h"

@interface HxPageViewController ()
@property (nonatomic, strong) SwapViewController * swapView;
@end

@implementation HxPageViewController
@synthesize swapView,windowView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self addSwapView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addSwapView{
    swapView = [self.storyboard instantiateViewControllerWithIdentifier:@"ID_SwapViewController"];
    swapView.size = 20;
    swapView.delegate = self;
    swapView.view.frame = self.windowView.bounds;
    
    [swapView willMoveToParentViewController:self];
    [self.windowView addSubview:swapView.view];
    [self addChildViewController:swapView];
}


#pragma mark --- Delegates ---


- (void)UpdateSwapViewDelegate:(NSUInteger)i forView:(id)view forCtl:(id)ctrl view:(viewType)viewType{
    
    if (MID_VIEW == viewType) {

    }
    
    // remove old views
    SwapViewController * sv = (SwapViewController*)ctrl;
    for (TestLoadViewController* c in sv.childViewControllers) {
        if (c.view.tag == viewType) {
            [c.view removeFromSuperview];
            [c removeFromParentViewController];
            break;
        }
    }
    
    TestLoadViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ID_TestLoadViewController"];
    
    vc.delegate = self;
    vc.view.frame =((UIView*)view).bounds;
    [vc willMoveToParentViewController:self];
    vc.view.tag = viewType;
    vc.index = i;
    [view addSubview:vc.view];
    [ctrl addChildViewController:vc];
}
@end
