//
//  ZLImagesCircleView.m
//  ZLImagesCircleView
//
//  Created by 张璐 on 15/8/31.
//  Copyright (c) 2015年 张璐. All rights reserved.
//

#import "ZLImagesCircleView.h"
#import "ZLImagesCircleCell.h"
#define ID @"item"
#define totalRowsInSection (self.iconsArray.count * 5000)
#define defaultDidScrollRow (NSUInteger)(totalRowsInSection * 0.5)


@interface ZLImagesCircleView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,weak)UICollectionView * collectionView;
@property (nonatomic,weak) UIPageControl * pageControl;
@property (nonatomic,strong) NSTimer * timer;

@end

@implementation ZLImagesCircleView

-(void)setIconsArray:(NSArray *)iconsArray
{
    _iconsArray = iconsArray;
    self.pageControl.numberOfPages = iconsArray.count;
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:defaultDidScrollRow inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
}
-(void)setPageContrlFrame:(CGRect)pageContrlFrame
{
    _pageContrlFrame = pageContrlFrame;
    self.pageControl.frame = pageContrlFrame;
}
-(void)setCurrentPageColor:(UIColor *)currentPageColor
{
    _currentPageColor = currentPageColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageColor;
}

-(void)setOtherPagesColor:(UIColor *)otherPagesColor
{
    _otherPagesColor = otherPagesColor;
    self.pageControl.pageIndicatorTintColor = otherPagesColor;
}
-(void)setTimeInterval:(CGFloat)timeInterval
{
    _timeInterval = timeInterval;
    if (self.timer) {
        [self removeTimer];
     }
        [self addTimer];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        CGRect rect = self.bounds;
        UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:layout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        //注册
        [collectionView registerClass:[ZLImagesCircleCell class] forCellWithReuseIdentifier:ID];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        self.collectionView = collectionView;
        [self addSubview:collectionView];
        
        UIPageControl * pageContrl = [[UIPageControl alloc]init];
        pageContrl.currentPageIndicatorTintColor = self.currentPageColor ? self.currentPageColor : [UIColor orangeColor];
        pageContrl.pageIndicatorTintColor = self.otherPagesColor ? self.otherPagesColor : [UIColor blueColor];
        self.pageControl = pageContrl;
        [self addSubview:pageContrl];
        

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    
    CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.9);
    CGSize size = CGSizeMake(60, 30);
    self.pageControl.center = center;
    self.pageControl.bounds = (CGRect){CGPointZero,size};
    
}
-(void)addTimer
{
    self.timer = [NSTimer timerWithTimeInterval:self.timeInterval target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
-(void)nextImage
{
    NSIndexPath * currentVisibleItemPath = [self.collectionView indexPathsForVisibleItems].firstObject;
    NSUInteger currentVisibleItem = currentVisibleItemPath.item;
    if ((currentVisibleItem % self.iconsArray.count) == 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:defaultDidScrollRow inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        currentVisibleItem = defaultDidScrollRow;
    }
    NSUInteger nextItem = currentVisibleItem + 1;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}
#pragma mark -
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return totalRowsInSection;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZLImagesCircleCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.iconName = self.iconsArray[indexPath.item % self.iconsArray.count];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath * currentVisibleItemPath = [collectionView indexPathsForVisibleItems].firstObject;
    self.pageControl.currentPage = currentVisibleItemPath.item % self.iconsArray.count;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self addTimer];
}
@end
