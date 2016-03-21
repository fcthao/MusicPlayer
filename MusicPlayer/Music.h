//
//  Music.h
//  MusicPlayer
//
//  Created by 范伟 on 16/3/21.
//  Copyright © 2016年 FanWei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject
/** 歌曲名称*/
@property (nonatomic,copy)NSString *name;
/** 专辑图片名称*/
@property (nonatomic,copy)NSString *image;
/** 歌词*/
@property (nonatomic,copy)NSString *lrc;
/** 带扩展名的歌曲名*/
@property (nonatomic,copy)NSString *mp3;
/** 歌手名称*/
@property (nonatomic,copy)NSString *singer;
/** 专辑的名称 */
@property (nonatomic,copy)NSString *album;
/** 类型*/
@property (nonatomic,strong)NSNumber *type;
@end
