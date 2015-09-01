//
//  TestViewController.m
//  ZLImagesCircleView
//
//  Created by 张璐 on 15/8/31.
//  Copyright (c) 2015年 张璐. All rights reserved.
//

#import "TestViewController.h"
#import "ZLImagesCircleView.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZLImagesCircleView * circleView = [[ZLImagesCircleView alloc]init];
    circleView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    circleView.iconsArray = @[@"1",@"2",@"3",@"4"];
    circleView.timeInterval = 3.0;
    [self.view addSubview:circleView];
}


@end
