//
//  ViewController.m
//  画圆盘
//
//  Created by admin on 2019/6/3.
//  Copyright © 2019年 admin. All rights reserved.
//

#import "ViewController.h"
#import "XF_MyCircleView.h"

@interface ViewController ()
@property (nonatomic, strong) XF_MyCircleView *circleView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat currentFloat;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XF_MyCircleView *circleView = [[XF_MyCircleView alloc] initWithFrame:CGRectMake(100, 100, 200, 180)];
    circleView.segmentColocArr =  @[K_blueColor,K_DeepColor,K_DeepColor];
    circleView.segmentDataArr = @[@"0.00%",@"",@"",@"7.50%",@"",@"",@"15.00%"];;
    
    [circleView bulidUI];
    self.circleView = circleView;
    [self.view addSubview:circleView];
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(k_time) userInfo:nil repeats:YES];
    
    [time fire];
    self.timer = time;
   
    self.currentFloat = 0.0;
}

- (void)k_time {
    self.currentFloat += 0.01;
    CGFloat allAngle = M_PI + M_PI_4;
    allAngle = allAngle * (self.currentFloat);
    self.circleView.lineView.transform = CGAffineTransformRotate(self.circleView.lineView.transform, allAngle);
}

@end
