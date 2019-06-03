//
//  XF_MyCircleView.h
//  画圆盘
//
//  Created by admin on 2019/6/3.
//  Copyright © 2019年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#define K_blueColor [UIColor colorWithRed:30.0/255 green:144.0/255 blue:255.0/255 alpha:1.0]
#define K_DeepColor [UIColor colorWithRed:216.0/255 green:216.0/255 blue:216.0/255 alpha:1.0]

NS_ASSUME_NONNULL_BEGIN

@interface XF_MyCircleView : UIView

@property (nonatomic, strong) UIView *lineView;

/** 分段颜色数组*/
@property (nonatomic, strong) NSArray *segmentColocArr;

/** 数据数组 如果不想显示的话 就传空串 譬如：@[@"0.00%",@"",@"",@"7.50%",@"",@"",@"15.00%"]*/
@property (nonatomic, strong) NSArray *segmentDataArr;

- (void)bulidUI;

@end

NS_ASSUME_NONNULL_END
