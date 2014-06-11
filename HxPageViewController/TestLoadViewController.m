//
//  TestLoadViewController.m
//  HxPageViewController
//
//  Created by Harry Xiao Han on 2014-06-11.
//  Copyright (c) 2014 Harry Han. All rights reserved.
//

#import "TestLoadViewController.h"

@interface TestLoadViewController ()

@end

@implementation TestLoadViewController
@synthesize delegate,index;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:NO];
    _indexLabel.center = self.view.center;
    _indexLabel.text = [NSString stringWithFormat:@"%lu",index];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
