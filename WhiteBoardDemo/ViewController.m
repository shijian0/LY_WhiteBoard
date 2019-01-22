//
//  ViewController.m
//  WhiteBoardDemo
//
//  Created by 勇 李 on 2018/3/12.
//  Copyright © 2018年 勇 李. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "DrawView_ShaperLayer.h"

typedef NS_ENUM(NSInteger,DrawViewType){
    DrawViewType_DrawRect,
    DrawViewType_ShapeLayer,
} ;

@interface ViewController ()
@property (nonatomic,strong)DrawView * drawView;
@property (nonatomic,strong)DrawView_ShaperLayer * drawView_ShapeLayer;
@property (nonatomic,strong)UIImageView * bgView;
@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UIButton *clean;
@property (weak, nonatomic) IBOutlet UIButton *reDo;

@property (nonatomic,assign)DrawViewType type;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = DrawViewType_ShapeLayer;
    [self.view addSubview:self.bgView];

    switch (self.type) {
        case DrawViewType_DrawRect:
            [self.view addSubview:self.drawView];
            break;
        case DrawViewType_ShapeLayer:
            [self.view addSubview:self.drawView_ShapeLayer];
        default:
            break;
    }
    [self.view bringSubviewToFront:self.clean];
    [self.view bringSubviewToFront:self.reDo];
    [self.view bringSubviewToFront:self.back];

    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w/16*9;
    self.drawView.frame  =CGRectMake(0, 0, w, h);
    self.bgView.frame = CGRectMake(0, 0, w, h);
    self.drawView_ShapeLayer.frame =  CGRectMake(0, 0, w, h);
}
- (IBAction)back:(id)sender {
    [self.drawView_ShapeLayer back];
}
- (IBAction)clean:(id)sender {
    [self.drawView_ShapeLayer clean];
}
- (IBAction)reDo:(id)sender {
    [self.drawView_ShapeLayer reDo];
}
//- (void)viewDidLayoutSubviews{
//
//}
-(DrawView*)drawView{
    if (!_drawView) {
        CGRect f = self.view.frame;
        f.size.height -=40;
        _drawView = [[DrawView alloc]initWithFrame:f];
    }
    return _drawView;
}
-(UIImageView*)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc]initWithFrame:self.view.frame];
        _bgView.image = [UIImage imageNamed:@"test"];
        _bgView.contentMode = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _bgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bgView;
}

-(DrawView_ShaperLayer*)drawView_ShapeLayer{
    if (!_drawView_ShapeLayer) {
        CGRect f = self.view.frame;
        f.size.height -=40;
        _drawView_ShapeLayer = [[DrawView_ShaperLayer alloc]initWithFrame:f];
        _drawView_ShapeLayer.layer.masksToBounds = YES;
        _drawView_ShapeLayer.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _drawView_ShapeLayer;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
