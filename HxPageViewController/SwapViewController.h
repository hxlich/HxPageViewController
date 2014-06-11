//
//  SwapViewController.h
//  KilnMonitorPad
//
//  Created by Harry Xiao Han on 2014-05-27.
//  Copyright (c) 2014 Suretrol Manufacturing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwapConfig.h"

typedef enum{
    LEFT_VIEW,
    MID_VIEW,
    RIGHT_VIEW
}viewType;

@protocol UpdateSwapViewDelegate <NSObject>

-(void)UpdateSwapViewDelegate:(NSUInteger)i forView:(id)view forCtl:(id)ctrl view:(viewType)viewType;

@end


@interface SwapViewController : UIViewController
{
    id delegate;
}

typedef enum{
    SWIP_LEFT  = -1,
    SWIP_NO    = 0,
    SWIP_RIGHT = 1
}SWIP_DIR;


@property (nonatomic) NSUInteger size;

@property (strong, nonatomic) IBOutlet UIView *rootView;

@property (nonatomic, retain) id delegate;
- (void)updateViewBufferSize:(NSUInteger)max;
- (void)updateViewsFrame:(CGRect)rootSize;
- (instancetype)init:(NSUInteger)farmNum;

@end
