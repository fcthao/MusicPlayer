//
//  LyricTool.h
//  MusicPlayer
//
//  Created by 范伟 on 16/3/22.
//  Copyright © 2016年 FanWei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  MusicLyric;

@interface MusicLyricTool : NSObject
/**
 *  指定歌词文件创建包含每行歌词的字符数组
 *
 *  @param lyricName <#lyricName description#>
 *
 *  @return <#return value description#>
 */
+ (NSArray<MusicLyric *> *)allLyricLinesWithLyricName: (NSString *)lyricName;
@end
