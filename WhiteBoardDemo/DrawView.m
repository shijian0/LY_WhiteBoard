//
//  DrawView.m
//  WhiteBoardDemo
//
//  Created by 勇 李 on 2018/3/12.
//  Copyright © 2018年 勇 李. All rights reserved.
//

#import "DrawView.h"
#import "LYbezierPath.h"

@interface DrawView()
@property (nonatomic,strong)NSMutableArray * bezierPathArr;
@property (nonatomic,strong)LYbezierPath * bezierPath;
@property (nonatomic,strong)UIColor * lineColor;
@end

@implementation DrawView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.lineColor = [UIColor redColor];
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;

    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    self.bezierPath = [[LYbezierPath alloc]init];
    self.bezierPath.lineColor = self.lineColor;
    [self.bezierPath moveToPoint:currentPosition];
    [self.bezierPathArr addObject:self.bezierPath];
    [self drawRect:self.frame];

    NSLog(@"began");
//    NSLog(@"%@",NSStringFromCGPoint(currentPosition));
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch preciseLocationInView:self];
    
    CGPoint middlePoint = midPoint(currentPoint,previousPoint);
    [self.bezierPath addQuadCurveToPoint:currentPoint controlPoint:middlePoint];
    [self setNeedsDisplay];
    [self drawRect:self.frame];

    NSLog(@"moved");

}
static CGPoint midPoint(CGPoint p0,CGPoint p1){
    return (CGPoint){
        (p0.x+p1.x)/2,
        (p0.y+p1.y)/2
    };
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch preciseLocationInView:self];
    
    CGPoint middlePoint = midPoint(currentPoint,previousPoint);
    [self.bezierPath addQuadCurveToPoint:currentPoint controlPoint:middlePoint];
    NSLog(@"%@:%@",NSStringFromCGPoint(currentPoint),NSStringFromCGPoint(middlePoint));
    [self setNeedsDisplay];
    [self drawRect:self.frame];

    NSLog(@"ended");

}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"cancelled");
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    NSLog(@":::::::::::%d",self.userInteractionEnabled);
    [[UIColor redColor] set];
    [self.bezierPathArr enumerateObjectsUsingBlock:^(LYbezierPath* bezierPaht, NSUInteger idx, BOOL * stop) {
        bezierPaht.lineCapStyle = kCGLineCapRound;
        bezierPaht.lineJoinStyle = kCGLineJoinRound;
        bezierPaht.lineWidth = 2;
        [bezierPaht strokeWithBlendMode:kCGBlendModeNormal alpha:1];
        [bezierPaht stroke];
    }];
}
- (NSMutableArray*)bezierPathArr{
    if (!_bezierPathArr) {
        _bezierPathArr = [NSMutableArray array];
    }
    return _bezierPathArr;
}
@end
