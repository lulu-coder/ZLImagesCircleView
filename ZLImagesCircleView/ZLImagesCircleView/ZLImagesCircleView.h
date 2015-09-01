//
//  ZLImagesCircleView.h
//  ZLImagesCircleView
//
//  Created by 张璐 on 15/8/31.
//  Copyright (c) 2015年 张璐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLImagesCircleView : UIView

//图片数组
@property (nonatomic,strong) NSArray * iconsArray;
//pageContrl位置尺寸
@property (nonatomic,assign) CGRect pageContrlFrame;
//选中页颜色
@property (nonatomic,strong) UIColor * currentPageColor;
//非选中页颜色
@property (nonatomic,strong) UIColor * otherPagesColor;
//轮播时间间隔
@property (nonatomic,assign) CGFloat timeInterval;

@end
