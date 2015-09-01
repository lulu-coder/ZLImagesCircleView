//
//  ZLImagesCircleCell.m
//  ZLImagesCircleView
//
//  Created by 张璐 on 15/8/31.
//  Copyright (c) 2015年 张璐. All rights reserved.
//

#import "ZLImagesCircleCell.h"

@interface ZLImagesCircleCell ()

@property(nonatomic,weak)UIImageView * iconView;

@end
@implementation ZLImagesCircleCell
-(void)setIconName:(NSString *)iconName
{
    _iconName = [iconName copy];
    self.iconView.image = [UIImage imageNamed:iconName];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
        UIImageView * iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.iconView.frame = self.bounds;
}
@end
