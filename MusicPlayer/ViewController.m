//
//  ViewController.m
//  MusicPlayer
//
//  Created by 范伟 on 16/3/21.
//  Copyright © 2016年 FanWei. All rights reserved.
//

#import "ViewController.h"
#import "MusicPlayerTool.h"
#import "Music.h"
#import <MJExtension.h>
#import "MusicLyricTool.h"
#import "MusicLyric.h"
#import "LyricLabel.h"

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
@property (weak, nonatomic) IBOutlet LyricLabel *lyricLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPlayingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

@property (strong, nonatomic) NSArray<Music *> *musics;

@property (assign, nonatomic) NSInteger currentMusicIndex;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) NSArray<MusicLyric *> *lyrics;
@end

@implementation ViewController
/**
 *  使用MJExtension进行字典转模型
 *
 *  @return <#return value description#>
 */
- (NSArray<Music *> *)musics {
    if (!_musics) {
        _musics = [Music mj_objectArrayWithFilename:@"mlist.plist"];
    }
    return _musics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //利用BarStyle样式设置玻璃效果
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlack];
    [toolbar setTranslucent:YES];
    [toolbar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.bgImageView addSubview:toolbar];
    //使用VisualFormatLanguage实现自动布局
    NSArray<NSLayoutConstraint *> *constraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[toolbar]-0-|" options:0 metrics:nil views:@{@"toolbar": toolbar}];
    NSArray<NSLayoutConstraint *> *constraintsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[toolbar]-0-|" options:0 metrics:nil views:@{@"toolbar": toolbar}];
    
    [self.bgImageView addConstraints:constraintsH];
    [self.bgImageView addConstraints:constraintsV];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    [self playMusic];
}
- (IBAction)playMusic {
    //两个按钮同时只显示一个
    self.playBtn.hidden = true;
    self.pauseBtn.hidden = false;
    //开始播放音乐
    Music *music = self.musics[self.currentMusicIndex];
    
    [[MusicPlayerTool sharedPlayerTool] playMusicWithMusicName:music.mp3];
    //显示歌词
    [MusicLyricTool allLyricLinesWithLyricName:music.lrc];
    //针对每首不同的歌曲，更新UI
    self.title = music.name;
    [self.bgImageView setImage:[UIImage imageNamed:music.image]];
    [self.albumImageView setImage:[UIImage imageNamed:music.image]];
    
    [self.albumNameLabel setText:music.album];
    [self.singerNameLabel setText:music.singer];
    
    self.lyrics = [MusicLyricTool allLyricLinesWithLyricName:music.lrc];
    
    [self.totalTimeLabel setText:[[MusicPlayerTool sharedPlayerTool] totalTime]];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 60
                                                  target:self
                                                selector:@selector(updateCurrentPlayingTime) userInfo:nil
                                                 repeats:true];
    
}

- (void)updateCurrentPlayingTime {
    [self.currentPlayingTimeLabel setText:[[MusicPlayerTool sharedPlayerTool] currentTimeOfMusic]];
    [self.progressView setProgress:[[MusicPlayerTool sharedPlayerTool] progress]];
    
    for (NSInteger i = 0; i < self.lyrics.count; ++ i) {
        MusicLyric *currentLyric = self.lyrics[i];
        MusicLyric *nextLyric = i == self.lyrics.count - 1 ? self.lyrics[i] : self.lyrics[i + 1];
        NSTimeInterval current = [[MusicPlayerTool sharedPlayerTool] currentTimeOfMusicFloat];
        if (current >= currentLyric.timePoint && current < nextLyric.timePoint) {
            [self.lyricLabel setText:currentLyric.lyricText];
            [self.lyricLabel setProgress:(current - currentLyric.timePoint) / (nextLyric.timePoint - currentLyric.timePoint)];
        }
    }
}
/**-
 *  暂停播放歌曲
 */
- (IBAction)pauseMusic {
    [self.playBtn setHidden:false];
    [self.pauseBtn setHidden:true];
    
    [[MusicPlayerTool sharedPlayerTool] pause];
    [self.timer invalidate];
    [self setTimer:nil];
}
/**
 *  播放上一首歌曲
 */
- (IBAction)previousMusic {
    self.currentMusicIndex = self.currentMusicIndex == 0 ? self.musics.count - 1 : self.currentMusicIndex - 1;
    [self playMusic];
}
/**
 *  播放下一首歌曲
 */
- (IBAction)nextMusic {
    _currentMusicIndex = _currentMusicIndex == self.musics.count - 1 ? 0 : _currentMusicIndex + 1;
    [self playMusic];
}

@end
