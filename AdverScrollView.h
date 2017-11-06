//
//  AdverScrollView.h
//  jiemian1shouye
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AdverScrollView : UIView

@property (strong ,nonatomic) NSArray *iconArr;
@property(copy,nonatomic) void(^myblock)(int);//点击图片触发的事件
@end
