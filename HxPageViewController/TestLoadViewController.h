//
//  TestLoadViewController.h
//  HxPageViewController
//
//  Created by Harry Xiao Han on 2014-06-11.
//  Copyright (c) 2014 Harry Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestLoadViewController : UIViewController{
    id delegate;
}
@property (nonatomic, retain) id delegate;
@property (nonatomic) NSUInteger index;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;


@end
