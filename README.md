# Slider-swift-oc
swift和oc版的轮播封装
 _scroll=[[AdverScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, W6(150))];
    _scroll.iconArr=_banners;
     __weak typeof(self) weakself = self;
    _scroll.myblock = ^(int taptag) {
        NSLog(@"%d",taptag);
     //点击banner事件触发
    };
    [_scrollview addSubview:_scroll];
