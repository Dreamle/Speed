//
//  XF_MyCircleView.m
//  画圆盘
//
//  Created by admin on 2019/6/3.
//  Copyright © 2019年 admin. All rights reserved.
//

#import "XF_MyCircleView.h"
//由角度转换弧度
#define DegreesToRadian(x) (M_PI * (x) / 180.0)
//由弧度转换角度
#define RadianToDegrees(radian) (radian*180.0)/(M_PI)

#define k_BeginAngle -(M_PI+M_PI_4)
#define k_EndAngle  M_PI_4




@interface XF_MyCircleView ()
@property (nonatomic, assign) CGPoint m_Center;

@property (nonatomic, strong) UILabel *k_currentProcessLab;
@end


@implementation XF_MyCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.m_Center = CGPointMake(frame.size.width/2, frame.size.height/2 + 30);
        self.segmentColocArr = @[K_blueColor,K_DeepColor,K_DeepColor];
        self.segmentDataArr = @[@"0.00%",@"",@"",@"7.50%",@"",@"",@"15.00%"];;
    }
    return self;
}


- (void)bulidUI {
    [self initial];
}

- (void)initial {
    self.backgroundColor = [UIColor clearColor];
    [self drawOutsideCircle];
    [self drawInnerCircle];
    [self drawInnerPerSegmentMark];
    [self drawLineViewAndCenterView];
}

/** 画外圆*/
- (void)drawOutsideCircle
{
    UIBezierPath *tickPath = [UIBezierPath bezierPathWithArcCenter:self.m_Center radius:self.bounds.size.width * 0.5 - 10 startAngle:k_BeginAngle  endAngle:k_EndAngle clockwise:YES];
    CAShapeLayer *perLayer = [CAShapeLayer layer];
    perLayer.lineWidth   = 1.5f;
    perLayer.strokeColor = [UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:1.0].CGColor;
    perLayer.fillColor = [UIColor whiteColor].CGColor;
    perLayer.path = tickPath.CGPath;
    [self.layer addSublayer:perLayer];
}


/** 画内圆*/
- (void)drawInnerCircle {
    
    CGFloat beginAngle = k_BeginAngle;
    CGFloat endAngle = k_EndAngle;
    
    CGFloat  paddingFramement = DegreesToRadian(3);
   
    
    NSArray *colorArr = nil;
    
    if (self.segmentColocArr.count) {
        colorArr = self.segmentColocArr;
    }
    
    NSInteger framgMent = colorArr.count;
    CGFloat framePerMent = (endAngle - beginAngle - paddingFramement * (framgMent - 1))/framgMent;
    
    for (int i = 0; i < framgMent; i++) {
        
       CGFloat fragmentBeginAngle =  beginAngle + (framePerMent + paddingFramement) * i;
        
       CGFloat fragmentEndAngle = fragmentBeginAngle + framePerMent;
        
        UIBezierPath *tickPath = [UIBezierPath bezierPathWithArcCenter:self.m_Center radius:self.bounds.size.width * 0.5 - 10 - 10 startAngle:fragmentBeginAngle endAngle:fragmentEndAngle clockwise:YES];
        
        tickPath.lineCapStyle = kCGLineCapRound;
        tickPath.lineJoinStyle = kCGLineJoinRound;
        
        CAShapeLayer *perLayer = [CAShapeLayer layer];
        perLayer.lineWidth   = 4.f;
        
        UIColor *curremtColor = colorArr[i];
        perLayer.strokeColor = curremtColor.CGColor;
        perLayer.fillColor = [UIColor whiteColor].CGColor;
        perLayer.path = tickPath.CGPath;
        [self.layer addSublayer:perLayer];
        
    }
}

/** 绘制刻度*/
- (void)drawInnerPerSegmentMark {
    
    NSArray *dataArr = nil;
    
    if (self.segmentDataArr.count) {
        dataArr = self.segmentDataArr;
    }
    
    CGFloat beginAngle = k_BeginAngle;
    CGFloat endAngle = k_EndAngle ;
    
    /** 线条刻度 默认为1*/
    CGFloat  paddingFramement = DegreesToRadian(1);
    NSInteger framgMent = dataArr.count;
    CGFloat framePerMent = (endAngle - beginAngle - paddingFramement * framgMent)/(framgMent - 1);
    
    for (int i = 0; i < framgMent; i++) {
        
        CGFloat fragmentBeginAngle =  beginAngle + (framePerMent +paddingFramement) * i;
        CGFloat fragmentEndAngle = fragmentBeginAngle + paddingFramement;
        
        UIBezierPath *tickPath = [UIBezierPath bezierPathWithArcCenter:self.m_Center radius:self.bounds.size.width * 0.5 - 10 - 10 - 5 startAngle:fragmentBeginAngle endAngle:fragmentEndAngle clockwise:YES];
        CAShapeLayer *perLayer = [CAShapeLayer layer];
        
        if (i % 2 == 0) {
            perLayer.lineWidth   = 5.f;
        } else {
            perLayer.lineWidth   = 2.5f;
        }
        
        
        perLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        perLayer.fillColor = [UIColor whiteColor].CGColor;
        perLayer.path = tickPath.CGPath;
        [self.layer addSublayer:perLayer];
        
        [self drawOutsideScaleWithAngel:fragmentEndAngle withData:i theText:dataArr[i]];
    }
}

- (void)drawOutsideScaleWithAngel:(CGFloat)textAngel withData:(int)index theText:(NSString *)tickText
{
    CGPoint point      = [self calculateTextPositonWithArcCenter:self.m_Center Angle:-textAngel];
    
    //默认label的大小30 * 14
    UILabel *text      = [[UILabel alloc] initWithFrame:CGRectMake(point.x - 15, point.y - 8, 40, 14)];
    
    
    if (index == 0 ) { //第一个的位置
        text.frame = CGRectMake(point.x - 15 - 10, point.y - 8 + 30, 40, 14);
    }
    if ((index + 1) == self.segmentDataArr.count) { //最后一个的位置
        text.frame = CGRectMake(point.x - 15 + 10, point.y - 8 + 30, 40, 14);
    }
    text.text          = tickText;
    text.font          = [UIFont systemFontOfSize:10];
    text.textColor     = [UIColor colorWithRed:0.54 green:0.78 blue:0.91 alpha:1.0];
    text.textAlignment = NSTextAlignmentCenter;
    if (tickText.length) {
        text.hidden = NO;
    } else {
        text.hidden = YES;
    }
    [self addSubview:text];
}

/** 绘制线条和中间的提示文字*/
- (void)drawLineViewAndCenterView {
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width * 0.5 - 10 - 10 - 5, 1.5)];
    lineView.backgroundColor = K_blueColor;
    lineView.center = self.m_Center;
    lineView.layer.anchorPoint = CGPointMake(1, 0.5);
    lineView.layer.allowsEdgeAntialiasing = YES;
    lineView.transform = CGAffineTransformMakeRotation(-M_PI_4);
    [self addSubview:lineView];
    
    self.lineView = lineView;
    
    
    //中间view
    UIView *k_centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    k_centerView.backgroundColor = [UIColor whiteColor];
    k_centerView.center = self.m_Center;
    [self addSubview:k_centerView];
    
    k_centerView.layer.cornerRadius = 20;
    k_centerView.layer.masksToBounds = YES;
    
    //
    UILabel *topLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, k_centerView.bounds.size.width, 20)];
    topLab.text = @"5%";
    topLab.font = [UIFont boldSystemFontOfSize:16];
    topLab.textAlignment = NSTextAlignmentCenter;
    topLab.textColor = K_blueColor;
    topLab.backgroundColor = [UIColor whiteColor];
    [k_centerView addSubview:topLab];
    self.k_currentProcessLab = topLab;
    
    UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(0, topLab.bounds.size.height, k_centerView.bounds.size.width, 20)];
    tipLab.text = @"当前显示";
    tipLab.font = [UIFont systemFontOfSize:10];
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.textColor = K_DeepColor;
    [k_centerView addSubview:tipLab];
}


//默认计算半径135
- (CGPoint)calculateTextPositonWithArcCenter:(CGPoint)center
                                       Angle:(CGFloat)angel
{
    CGFloat x = (self.m_Center.x - 30) * cosf(angel);
    CGFloat y = (self.m_Center.y -60) * sinf(angel);
    
    return CGPointMake(center.x + x, center.y - y);
}



@end
