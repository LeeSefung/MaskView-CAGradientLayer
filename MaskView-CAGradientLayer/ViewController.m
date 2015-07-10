//
//  ViewController.m
//  MaskView-CAGradientLayer
//
//  Created by rimi on 15/7/9.
//  Copyright (c) 2015年 LeeSefung. All rights reserved.
//  通过CAGradientLayer创建alpha通道，再将这个alpha通道加到maskView上,再讲maskView设置为图片的maskView,之后通过改变maskview的位置实现图片切换动画。
//  https://github.com/LeeSefung/MaskView-CAGradientLayer.git
//

#import "ViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController () {
    
    UIImageView *_imageView1;
    UIImageView *_imageView2;
    CAGradientLayer *_gradientLayer1;
    CAGradientLayer *_gradientLayer2;
    UIView *_containerView1;
    UIView *_containerView2;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    // 加载图片
    _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _imageView2.image = [UIImage imageNamed:@"2"];
    [self.view addSubview:_imageView2];
    
    // 创建出CAGradientLayer（创建alpha通道）
    _gradientLayer2 = [CAGradientLayer layer];
    _gradientLayer2.frame            = CGRectMake(-1.5*WIDTH, 0, 2.5*WIDTH, HEIGHT);
    _gradientLayer2.colors           = @[(__bridge id)[UIColor clearColor].CGColor,
                                         (__bridge id)[UIColor clearColor].CGColor,
                                         (__bridge id)[UIColor blackColor].CGColor];
    _gradientLayer2.locations        = @[@(0.4), @(0.4), @(0.6)];
    _gradientLayer2.startPoint       = CGPointMake(0, 0);
    _gradientLayer2.endPoint         = CGPointMake(1, 0);
    
    // 容器view --> 用于加载创建出的CAGradientLayer（_containerView2即maskView）
    _containerView2 = [[UIView alloc] initWithFrame:_imageView2.bounds];
    [_containerView2.layer addSublayer:_gradientLayer2];
    
    // 设定maskView
    _imageView2.maskView = _containerView2;
    
    ///////////////////////////////////////////////////////////////////////
    
    // 加载图片
    _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _imageView1.image = [UIImage imageNamed:@"1"];
    [self.view addSubview:_imageView1];
    
    // 创建出CAGradientLayer
    _gradientLayer1 = [CAGradientLayer layer];
    _gradientLayer1.frame            = CGRectMake(-1.5*WIDTH, 0, 2.5*WIDTH, HEIGHT);
    _gradientLayer1.colors           = @[(__bridge id)[UIColor clearColor].CGColor,
                                         (__bridge id)[UIColor blackColor].CGColor];
    _gradientLayer1.locations        = @[@(0.4), @(0.6)];
    _gradientLayer1.startPoint       = CGPointMake(0, 0);
    _gradientLayer1.endPoint         = CGPointMake(1, 0);
    
    // 容器view --> 用于加载创建出的CAGradientLayer
    _containerView1 = [[UIView alloc] initWithFrame:_imageView1.bounds];
    [_containerView1.layer addSublayer:_gradientLayer1];
    
    // 设定maskView
    _imageView1.maskView = _containerView1;
    
    [self hidden1];
}

- (void)hidden1 {
    
    // 给maskView做动画效果
    [UIView animateWithDuration:3.f animations:^{
        
        // 改变位移
        CGRect frame        = _containerView1.frame;
        frame.origin.x     += 1.5*WIDTH;
        
        // 重新赋值
        _containerView1.frame = frame;
    } completion:^(BOOL finished) {
        [self.view insertSubview:_imageView1 belowSubview:_imageView2];
        // 改变位移
        CGRect frame        = _containerView1.frame;
        frame.origin.x     -= 1.5*WIDTH;
        
        // 重新赋值
        _containerView1.frame = frame;
        [self hidden2];
    }];
}

- (void)hidden2 {
    
    // 给maskView做动画效果
    [UIView animateWithDuration:3.f animations:^{
        
        // 改变位移
        CGRect frame        = _containerView2.frame;
        frame.origin.x     += 1.5*WIDTH;
        
        // 重新赋值
        _containerView2.frame = frame;
    } completion:^(BOOL finished) {
        
        [self.view insertSubview:_imageView2 belowSubview:_imageView1];
        // 改变位移
        CGRect frame        = _containerView2.frame;
        frame.origin.x     -= 1.5*WIDTH;
        
        // 重新赋值
        _containerView2.frame = frame;
        [self hidden1];
    }];
}

@end
