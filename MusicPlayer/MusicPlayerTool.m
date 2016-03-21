//
//  MusicPlayerTool.m
//  MusicPlayer
//
//  Created by 范伟 on 16/3/21.
//  Copyright © 2016年 FanWei. All rights reserved.
//

#import "MusicPlayerTool.h"
#import <AVFoundation/AVFoundation.h>

@interface MusicPlayerTool()
/**
 *  音乐播放器
 */
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, copy) NSString *currentMusicName;
@end


@implementation MusicPlayerTool

/**
 *  单例方法
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedPlayerTool {
    static MusicPlayerTool *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
/**
 *  指定音乐文件名播放一首歌曲
 *
 *  @param musicName <#musicName description#>
 */
- (void)playMusicWithMusicName:(NSString *)musicName {
    if (!musicName) {
        return;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:musicName ofType:nil];
    //需要进行path空值检查，否则有可能报错
    if (!path) {
        return;
    }
    NSURL *url = [NSURL fileURLWithPath:path];
    if (!url) {
        return;
    }
    NSError *error = nil;
    if (![self.currentMusicName isEqualToString:musicName]) {
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        self.currentMusicName = musicName;
    }
    if (error == nil && [self.player prepareToPlay]) {
        [self.player play];//异步播放！
    }
}
/**
 *  暂停播放
 */
- (void)pause {
    if ([self.player isPlaying]) {
        [self.player pause];//pauses playback, but remains ready to play.
    }
}

@end
