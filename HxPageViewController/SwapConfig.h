//
//  SwapConfig.h
//  HxPageViewController
//
//  Created by Harry Xiao Han on 2014-06-11.
//  Copyright (c) 2014 Harry Han. All rights reserved.
//

#ifndef HxPageViewController_SwapConfig_h
#define HxPageViewController_SwapConfig_h

// all the percentage are based on super view
#define HIDE_VIEW_VISIBLE_WIDTH_PERCENT    5
#define GAP_WIDTH_BETWEEN_VIEWS_PERCENT    5
#define MAIN_VIEW_WIDTH_PERCENT            (100 - HIDE_VIEW_VISIBLE_WIDTH_PERCENT*2 - GAP_WIDTH_BETWEEN_VIEWS_PERCENT*2)
#define HIDE_VIEW_VISIBLE_HEIGHT_PERCENT   5
#define MAIN_VIEW_HEIGHT_PERCENT           (100)
#define MAX_WIDTH_WITHOUT_NEW_VIEW_PERCENT (40-MAIN_VIEW_WIDTH_PERCENT)

// if there is only 30% left on visible area, we will automatically move new view in
#define AUTO_CHANGE_TO_NEW_VIEW_PERCENT    10
#define MANUAL_CHANGE_TO_NEW_VIEW_PERCENT  20
#define CAL_VIEW_REAL_SIZE(real, p)        (((real)*(p))/100)
#define QUICK_SLIDE_ANIMATION_DURATION      .18
#define SLIDE_ANIMATION_DURATION            0.3
#define FAST_VELOCITY_FOR_SWIPE_FOLLOW_DIRECTION 1200

#endif
