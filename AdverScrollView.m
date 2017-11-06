//
//  AdverScrollView.m
//  jiemian1shouye
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "AdverScrollView.h"
#import "USTDataModel.h"
@interface AdverScrollView()<UIScrollViewDelegate>
@property(weak,nonatomic)UIScrollView *scrollView;
@property(weak,nonatomic)UIPageControl *pageView;
@property(strong,nonatomic)NSTimer *timer;
@property (strong ,nonatomic) NSMutableArray *iconArray;
@property(assign,nonatomic)int flag;
@end
@implementation AdverScrollView
-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self=[super initWithFrame:frame]) {
        //创建轮播图的大小
        UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,CGRectGetHeight(frame))];
        scrollView.autoresizingMask = 0xFF;
        _flag=0;
        scrollView.contentMode = UIViewContentModeCenter;
        scrollView.delegate=self;
        scrollView.pagingEnabled=YES;
        [self addSubview:scrollView];
        _scrollView=scrollView;
        UIPageControl *pageView=[[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth/2-100, CGRectGetMaxY(scrollView.frame)-20, 200, 20)];
        [self addSubview:pageView];
        _pageView=pageView;
        [self addTime];
    }
    return self;
}
-(void)addTime
{
    _flag=0;
    _timer=[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
}

-(void)setIconArr:(NSArray *)iconArr
{
    _iconArr=iconArr;
    if (iconArr.count < 1){
        
    }else{
    _iconArray=[NSMutableArray arrayWithArray:iconArr];
    
    //  NSLog(@"%@",[iconArr lastObject]);
    
    [_iconArray addObject:[iconArr firstObject]];
    [_iconArray insertObject:[iconArr lastObject] atIndex:0];
    
    
    
    // NSLog(@"%d",_iconArray.count);
    
    for (int i=0; i<_iconArray.count; i++) {
        
        //   NSLog(@"%d",i);
        USTHomeBannerV2 *dict=_iconArray[i];
        NSLog(@"%@",dict);
        UIImageView *imageView=[PublicView imageViewWithurlimage:[NSString stringwithmystring:dict.banner_img] andFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, CGRectGetHeight(_scrollView.frame)) andplaceimage:@"banner-moren"];
        
        imageView.tag=1000+i;
        
        // imageView.backgroundColor=[UIColor redColor];
        imageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [imageView addGestureRecognizer:tap];
        
        [_scrollView addSubview:imageView];
        
    }
    
    
    _scrollView.contentOffset=CGPointMake(kScreenWidth, 0);
    
    _scrollView.contentSize=CGSizeMake(kScreenWidth*_iconArray.count, 0);//禁止上下滑动
    
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.showsHorizontalScrollIndicator=YES;
    _pageView.currentPage=0;
    _pageView.numberOfPages=iconArr.count;
    _pageView.pageIndicatorTintColor=[UIColor grayColor];
    _pageView.currentPageIndicatorTintColor=[UIColor redColor];
    [_timer fire];
    }
    
}
-(void)tapClick:(UITapGestureRecognizer *)tap
{
    
    //NSLog(@"%d",tap.view.tag);
    int i=(int)tap.view.tag-1001;
    
    if (_iconArray.count<=1) {
        
        i++;
    }
    self.myblock(i);
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    int i=(scrollView.contentOffset.x+kScreenWidth/2)/kScreenWidth;
    
    //  NSLog(@"dryfthgjbkn=======%d",i);
    //  NSLog(@"=============");
    
    if (i>=_iconArray.count-1) {
        scrollView.contentOffset=CGPointMake(kScreenWidth, 0);
        i=0;
    }else if(i<1)
    {
        int z=(int)_iconArray.count;
      scrollView.contentOffset=CGPointMake(kScreenWidth*(z-2), 0);
        i=z-1;
    }else
    {
        scrollView.contentOffset=CGPointMake(kScreenWidth*i, 0);
        i--;
    }
    NSLog(@"stycfvjyhbknlm%d",i);
    
    _pageView.currentPage=i;
    
}
-(void)timerClick
{
    if (_flag==0) {
        _flag=1;
        return;
    }
    
    int i=(_scrollView.contentOffset.x+kScreenWidth/2)/kScreenWidth;
    
    //NSLog(@"=======定时器%d",i);
    
    if (i<_iconArray.count-2) {
        //   i++;
    }else
    {
        i=0;
    }
    _pageView.currentPage=i;
    _scrollView.contentOffset=CGPointMake(kScreenWidth*(i+1), 0);
    
    
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //   [_timer setFireDate:[NSDate distantPast]];
    
    [self addTime];
    [_timer fire];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //关闭定时器
    //关闭定时器
    //[_timer setFireDate:[NSDate distantFuture]];
    //取消定时器
    
    [_timer invalidate];
    
    _timer = nil;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
