//
//  SettingsViewController.m
//  KMNavigationBarTransitionPatch
//
//  Created by hncoder on 2017/10/14.
//  Copyright © 2017年 com. All rights reserved.
//

#import "SettingsViewController.h"
#include <math.h>

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    long rand = (random() % 3);
    if (rand == 0) {
        self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    } else if (rand == 1) {
        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    } else {
       self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    }
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"Next" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nextBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)next:(id)sender {
    SettingsViewController *settingsCtrl = [[SettingsViewController alloc] init];
    [self.navigationController pushViewController:settingsCtrl animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
