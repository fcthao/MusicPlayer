//
//  ViewController.m
//  MusicPlayer
//
//  Created by 范伟 on 16/3/21.
//  Copyright © 2016年 FanWei. All rights reserved.
//

#import "ViewController.h"
#import "MusicPlayerTool.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *previousBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;

@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lyricLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPlayingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

//@property (strong, nonatomic) NSArray
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //利用BarStyle样式设置玻璃效果
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlack];
    [toolbar setTranslucent:YES];
    [self.bgImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.bgImageView addSubview:toolbar];
    //使用VisualFormatLanguage实现自动布局
    NSArray<NSLayoutConstraint *> *constraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[toolbar]-0-|" options:0 metrics:nil views:@{@"toolbar": toolbar}];
    NSArray<NSLayoutConstraint *> *constraintsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[toolbar]-0-|" options:0 metrics:nil views:@{@"toolbar": toolbar}];
    
    [self.bgImageView addConstraints:constraintsH];
    [self.bgImageView addConstraints:constraintsV];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTranslatesAutoresizingMaskIntoConstraints:YES];
}
- (IBAction)playMusic {
    
}
- (IBAction)pauseMusic {
}
- (IBAction)previousMusic {
}
- (IBAction)nextMusic {
}

@end
