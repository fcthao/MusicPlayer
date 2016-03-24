//
//  MusicPlayerTool.h
//  MusicPlayer
//
//  Created by 范伟 on 16/3/21.
//  Copyright © 2016年 FanWei. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MusicPlayerTool : NSObject


+ (instancetype)sharedPlayerTool;

- (void)playMusicWithMusicName:(NSString *)musicName;

- (void)pause;
/**
 *  当前播放器播放的总时间（字符串）
 *
 *  @return <#return value description#>
 */
- (NSString *)totalTime;
/**
 *  当前播放器播放的总时间(数字)
 *
 *  @return <#return value description#>
 */
- (NSTimeInterval)totalTimeFloat;

- (NSString *)currentTimeOfMusic;
- (NSTimeInterval)currentTimeOfMusicFloat;

- (CGFloat)progress;


@end
