//
//  SwapViewController.m
//  KilnMonitorPad
//
//  Created by Harry Xiao Han on 2014-05-27.
//  Copyright (c) 2014 Suretrol Manufacturing. All rights reserved.
//

#import "SwapViewController.h"

@interface SwapViewController ()
@property (nonatomic, strong) UIPanGestureRecognizer *monitorPanRecognizer;
@property (nonatomic, assign) CGPoint draggingPoint;
@property (nonatomic, assign) CGRect tableLeftOriginPos;
@property (nonatomic, assign) CGRect tableMidOriginPos;
@property (nonatomic, assign) CGRect tableRightOriginPos;
@property (strong, nonatomic) UIView *tableViewLeft;
@property (strong, nonatomic) UIView *tableViewMid;
@property (strong, nonatomic) UIView *tableViewRight;
@property (nonatomic) NSUInteger index;
@end

@implementation SwapViewController

@synthesize tableViewLeft, tableViewMid, tableViewRight;
@synthesize index, size;
@synthesize tableLeftOriginPos, tableMidOriginPos,tableRightOriginPos;
@synthesize delegate;

#pragma mark --- Override Methods ---

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    tableViewLeft = [[UIView alloc] init];
    tableViewMid = [[UIView alloc] init];
    tableViewRight = [[UIView alloc] init];
    [_rootView addSubview:tableViewLeft];
    [_rootView addSubview:tableViewMid];
    [_rootView addSubview:tableViewRight];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- Initialization ---

- (void)setup{
    [self setupViewsPos:_rootView];
    [self loadViews:size];
}

- (instancetype)init:(NSUInteger)farmNum{
    self = [super init];
    
    if(self){
        [self updateViewBufferSize:farmNum];
        [self setup];
    }
    
    return self;
}

#pragma mark --- Public Methods ---

- (void)updateViewBufferSize:(NSUInteger)max{
    size = max;
}

- (void)updateViewsFrame:(CGRect)rootSize{
    _rootView.frame = rootSize;
    [self setupViewsPos:_rootView];
    [self updateLeftView:index-1];
    [self updateMidView:index];
    [self updateRightView:index+1];
}

#pragma mark --- Private Methods ---

- (void)updateLeftView:(NSUInteger)i{
    
    if (![self isValidItem:i]) {
        return;
    }
    
    tableViewLeft.hidden = YES;
    [self.delegate UpdateSwapViewDelegate:i
                                  forView:tableViewLeft
                                   forCtl:self
                                     view:LEFT_VIEW];
    tableViewLeft.hidden = NO;
}

- (void)updateMidView:(NSUInteger)i{
    
    if (![self isValidItem:i]) {
        return;
    }

    tableViewMid.hidden = YES;
    [self.delegate UpdateSwapViewDelegate:i
                                  forView:tableViewMid
                                   forCtl:self
                                     view:MID_VIEW];
    tableViewMid.hidden = NO;
}

- (void)updateRightView:(NSUInteger)i{
    
    if (![self isValidItem:i]) {
        return;
    }
    
    tableViewRight.hidden = YES;
    [self.delegate UpdateSwapViewDelegate:i
                                  forView:tableViewRight
                                   forCtl:self
                                     view:RIGHT_VIEW];
    tableViewRight.hidden = NO;
}

- (void)setupViewsPos:(UIView*)root{
    // get root view frame
    CGRect rootFrame = root.bounds;
    
    
    // left view
    
    CGRect leftFrame;
    leftFrame.origin.y = 0;
    leftFrame.size.width = CAL_VIEW_REAL_SIZE(rootFrame.size.width, MAIN_VIEW_WIDTH_PERCENT);
    leftFrame.origin.x = CAL_VIEW_REAL_SIZE(rootFrame.size.width, HIDE_VIEW_VISIBLE_WIDTH_PERCENT)-leftFrame.size.width;
    leftFrame.size.height = CAL_VIEW_REAL_SIZE(rootFrame.size.height, MAIN_VIEW_HEIGHT_PERCENT);
    tableViewLeft.frame = leftFrame;
    tableViewLeft.layer.cornerRadius = 10.0f;
    tableLeftOriginPos = leftFrame;
    //[root setNeedsDisplay];
    // mid view
    CGRect midFrame;
    midFrame.origin.x = CAL_VIEW_REAL_SIZE(rootFrame.size.width, HIDE_VIEW_VISIBLE_WIDTH_PERCENT+GAP_WIDTH_BETWEEN_VIEWS_PERCENT);
    midFrame.origin.y = 0;
    midFrame.size.width = CAL_VIEW_REAL_SIZE(rootFrame.size.width, MAIN_VIEW_WIDTH_PERCENT);
    midFrame.size.height = CAL_VIEW_REAL_SIZE(rootFrame.size.height, MAIN_VIEW_HEIGHT_PERCENT);
    tableViewMid.frame = midFrame;
    tableViewMid.layer.cornerRadius = 10.0f;
    tableMidOriginPos = midFrame;
    [root setNeedsDisplay];
    //[tableViewMid setNeedsDisplay];
    // right view
    CGRect rightFrame;
    rightFrame.origin.x = CAL_VIEW_REAL_SIZE(rootFrame.size.width, 100-HIDE_VIEW_VISIBLE_WIDTH_PERCENT);
    rightFrame.origin.y = 0;
    rightFrame.size.width = CAL_VIEW_REAL_SIZE(rootFrame.size.width, MAIN_VIEW_WIDTH_PERCENT);
    rightFrame.size.height = CAL_VIEW_REAL_SIZE(rootFrame.size.height, MAIN_VIEW_HEIGHT_PERCENT);
    tableViewRight.frame = rightFrame;
    tableViewRight.layer.cornerRadius = 10.0f;
    tableRightOriginPos = rightFrame;

}

- (void)loadViews:(NSUInteger)max{
    [tableViewMid addGestureRecognizer:self.monitorPanRecognizer];
    if (max == 0) {
        return;
    }
    index = 0;
    tableViewLeft.hidden = YES;
    [self updateMidView:index];
    if (max == 1) {
        tableViewRight.hidden = YES;
        return;
    }
    [self updateRightView:index+1];
}

- (void)updateViews:(NSInteger)direction{
    if ( direction  == SWIP_RIGHT) {
        index--;
    }else if( direction == SWIP_LEFT){
        index++;
    }else{
        return;
    }
    
    [self updateLeftView:index-1];
    [self updateMidView:index];
    [self updateRightView:index+1];
}
- (void)changeToNewView:(NSInteger)direction{
    
    tableViewLeft.hidden = YES;
    tableViewMid.hidden = YES;
    tableViewRight.hidden = YES;
    
    
    tableViewLeft.frame = tableLeftOriginPos;
    tableViewMid.frame = tableMidOriginPos;
    tableViewRight.frame = tableRightOriginPos;
    
    tableViewMid.hidden = NO;
    
    [self updateViews:direction];
    
    if ([self isFirstItem:index]) {
        tableViewLeft.hidden = YES;
    }else{
        tableViewLeft.hidden = NO;
    }
    
    if ([self isLastItem:index]) {
        tableViewRight.hidden = YES;
    }else{
        tableViewRight.hidden = NO;
    }
}
#pragma mark --- Listeners ---



- (void)monitorPanDetected:(UIPanGestureRecognizer *)aPanRecognizer{
    
    CGPoint translation = [aPanRecognizer translationInView:aPanRecognizer.view];
    CGPoint velocity = [aPanRecognizer velocityInView:aPanRecognizer.view];
	NSInteger movement = translation.x - self.draggingPoint.x;
    
    if (aPanRecognizer.state == UIGestureRecognizerStateBegan){
        self.draggingPoint = translation;
    }else if (aPanRecognizer.state == UIGestureRecognizerStateChanged){
        static CGFloat lastHorizontalLocation = 0;
        CGFloat newHorizontalLocation = tableViewMid.frame.origin.x;
        
		lastHorizontalLocation = newHorizontalLocation;
		
		newHorizontalLocation += movement;
        
		self.draggingPoint = translation;
        
        if ([self isReadyToChangeToNewView:tableViewMid.center]) {
            [self newViewSliceIn:(movement < 0 ? SWIP_LEFT : SWIP_RIGHT)];
            aPanRecognizer.enabled = NO;
            aPanRecognizer.enabled = YES;
        }else{
            CGRect rect = tableViewMid.frame;
            rect.origin.x = newHorizontalLocation;
            tableViewMid.frame = rect;
            
            rect = tableViewLeft.frame;
            rect.origin.x += movement;
            tableViewLeft.frame = rect;
            
            rect = tableViewRight.frame;
            rect.origin.x += movement;
            tableViewRight.frame = rect;
        }
        
    }else if (aPanRecognizer.state == UIGestureRecognizerStateEnded){
        NSInteger currentX = tableViewMid.frame.origin.x - tableMidOriginPos.origin.x;
        NSInteger positiveVelocity = (velocity.x > 0) ? velocity.x : velocity.x * -1;
        if (positiveVelocity >= FAST_VELOCITY_FOR_SWIPE_FOLLOW_DIRECTION){
            
            if (velocity.x > 0){
                // Moving Right
				if (currentX > 0){
					[self newViewSliceIn:SWIP_RIGHT];
				}else{
                    [self revealView];
				}
			}else{
                // Moving Left
				if (currentX > 0){
                    [self revealView];
				}else{
                    [self newViewSliceIn:SWIP_LEFT];
				}
			}
        }else{
            if ([self isReadyToChangeToNewView:tableViewMid.center]) {
                if ([self isFirstItem:index] || [self isLastItem:index]) {
                    [self revealView];
                }else{
                    [self newViewSliceIn:(movement < 0 ? SWIP_LEFT: SWIP_RIGHT)];
                }
            }else{
                [self revealView];
            }
        }
    }
}


#pragma mark --- Animations ---

- (void)newViewSliceIn:(NSInteger)direction{
    [UIView animateWithDuration:QUICK_SLIDE_ANIMATION_DURATION
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect rect_1 = tableViewLeft.frame;
                         CGRect rect_2 = tableViewMid.frame;
                         CGRect rect_3 = tableViewRight.frame;
                         if (direction > 0) {
                             // swipe to right
                             rect_2.origin = tableRightOriginPos.origin;
                             rect_1.origin = tableMidOriginPos.origin;
                             tableViewLeft.frame = rect_1;
                             tableViewMid.frame = rect_2;
                             tableViewRight.frame = rect_3;
                         }else{
                             // swipe to left
                             rect_3.origin = tableMidOriginPos.origin;
                             rect_2.origin = tableLeftOriginPos.origin;
                             tableViewLeft.frame = rect_1;
                             tableViewMid.frame = rect_2;
                             tableViewRight.frame = rect_3;
                         }
                     }
                     completion:^(BOOL finished) {
                         if (([self isFirstItem:index] && direction == SWIP_RIGHT) ||
                             ([self isLastItem:index] && direction == SWIP_LEFT)){
                             
                             [self revealView];
                             return;
                         };
                         [self changeToNewView:direction];
                     }];
}

- (void)revealView{
    [UIView animateWithDuration:QUICK_SLIDE_ANIMATION_DURATION
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         tableViewLeft.frame = tableLeftOriginPos;
                         tableViewMid.frame = tableMidOriginPos;
                         tableViewRight.frame = tableRightOriginPos;
                         
                     }
                     completion:^(BOOL finished) {
                     }];
    
}

#pragma mark --- Setter & Getters ---


- (UIPanGestureRecognizer *)monitorPanRecognizer{
	if (!_monitorPanRecognizer)
	{
		_monitorPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(monitorPanDetected:)];
	}
	
	return _monitorPanRecognizer;
}

- (BOOL)isReadyToChangeToNewView:(CGPoint)center{
    CGPoint edgeMax;
    CGPoint edgeMin;
    edgeMin.x = _rootView.bounds.size.width*AUTO_CHANGE_TO_NEW_VIEW_PERCENT/100;
    edgeMax.x = _rootView.bounds.size.width - edgeMin.x;
    
    if (center.x < edgeMin.x || center.x >edgeMax.x) {
        return YES;
    }
    return NO;
}

- (BOOL)isFirstItem:(NSInteger)i{
    return ( i == 0) ? YES : NO;
}


- (BOOL)isLastItem:(NSInteger)i{
    return ( i  == size-1 ) ? YES : NO;
}

- (BOOL) isValidItem:(NSInteger)i{
    return ( i < size ) ? YES : NO;
}
@end