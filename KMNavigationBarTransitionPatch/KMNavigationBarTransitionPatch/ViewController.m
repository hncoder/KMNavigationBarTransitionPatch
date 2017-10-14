//
//  ViewController.m
//  KMNavigationBarTransitionPatch
//
//  Created by hncoder on 2017/10/14.
//  Copyright © 2017年 com. All rights reserved.
//

#import "ViewController.h"
#import "SettingsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn.frame = CGRectMake(100, 300, 100, 40);
    [testBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [testBtn setTitle:@"Test" forState:UIControlStateNormal];
    [testBtn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
}

- (void)test:(id)sender {
    UINavigationController *naviCtr = [[UINavigationController alloc] initWithRootViewController:[SettingsViewController new]];
    [self presentViewController:naviCtr animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
