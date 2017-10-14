//
//  UIViewController+KMNavigationBarTransitionPatch.m
//  KMNavigationBarTransitionPatch
//
//  Created by hncoder on 2017/10/14.
//  Copyright © 2017年 com. All rights reserved.
//

#import "UIViewController+KMNavigationBarTransitionPatch.h"
#import "UIViewController+KMNavigationBarTransition_internal.h"
#import "KMSwizzle.h"

@interface UIViewController(KMNavigationBarTransition_Internal_Extension)
// Expose KMNavigationBarTransition private method
- (void)km_resizeTransitionNavigationBarFrame;
@end

#define kBarTintColorViewTag    10001
@implementation UIViewController(KMNavigationBarTransitionPatch)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        KMSwizzleMethod([self class],
                        @selector(km_resizeTransitionNavigationBarFrame),
                        @selector(km_resizeTransitionNavigationBarFramePatch));
        
        KMSwizzleMethod([self class],
                        @selector(km_addTransitionNavigationBarIfNeeded),
                        @selector(km_addTransitionNavigationBarIfNeededPatch));
    });
}

- (void)km_resizeTransitionNavigationBarFramePatch {
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 11.0) {
        [self km_resizeTransitionNavigationBarFramePatch];
    } else {
        // 兼容iOS11,将原来方法修改成新的方式，可对照源码查看区别
        if (!self.view.window) {
            return;
        }
        // 1.修改Bar的frame
        CGRect rect = [self.navigationController.navigationBar.superview convertRect:self.navigationController.navigationBar.frame toView:self.view];
        rect.origin.x = 0;
        self.km_transitionNavigationBar.frame = rect;
        
        // 2.修改影响Bar背景色的backgroundView的frame
        UIView *backgroundView = [self.navigationController.navigationBar valueForKey:@"_backgroundView"];
        UIView *transitionBackgroudView = [self.km_transitionNavigationBar valueForKey:@"_backgroundView"];
        transitionBackgroudView.frame = backgroundView.frame;
        
        // 3.修改影响Bar背景色的自添加View的frame
        //（iOS11上，当push新controller时，如果当前self为fromViewController，那么上述第2步中，transitionBackgroudView的高度后续又会被系统莫名修改为44，导致状态栏区域变为透明，所以再添加一个View来替代_backgroundView，覆盖状态栏区域的barTintColor显示）
        [[self.km_transitionNavigationBar viewWithTag:kBarTintColorViewTag] setFrame:backgroundView.frame];
    }
}

- (void)km_addTransitionNavigationBarIfNeededPatch {
    [self km_addTransitionNavigationBarIfNeededPatch];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
        UINavigationBar *bar = self.km_transitionNavigationBar;
        if (bar && ![bar viewWithTag:kBarTintColorViewTag]) {
            // 添加一个View来替代_backgroundView，覆盖状态栏区域的barTintColor显示
            UIView *backgroundView = [self.navigationController.navigationBar valueForKey:@"_backgroundView"];
            UIView *barTintColorView = [UIView new];
            barTintColorView.frame = backgroundView.frame;
            [barTintColorView setTag:kBarTintColorViewTag];
            barTintColorView.backgroundColor = bar.barTintColor;
            [bar insertSubview:barTintColorView atIndex:0];
        }
    }
}

@end
