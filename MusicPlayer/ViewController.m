//
//  ViewController.m
//  MusicPlayer
//
//  Created by 范伟 on 16/3/21.
//  Copyright © 2016年 FanWei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (null_resettable, nonatomic, strong) UIProgressView *progressView;

@end

@implementation ViewController

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        [self.view addSubview:_progressView];
        [_progressView setBackgroundColor:[UIColor orangeColor]];
        [_progressView setProgress:0.3];
    }
    return _progressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.progressView setFrame:CGRectMake(50, 50, 200, 4)];
}

@end
