//
//  HxPageViewController.h
//  HxPageViewController
//
//  Created by Harry Xiao Han on 2014-06-11.
//  Copyright (c) 2014 Harry Han. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwapViewController.h"
#import "TestLoadViewController.h"

@interface HxPageViewController : UIViewController<UpdateSwapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *windowView;

@end
