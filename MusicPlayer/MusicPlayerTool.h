//
//  MusicPlayerTool.h
//  MusicPlayer
//
//  Created by 范伟 on 16/3/21.
//  Copyright © 2016年 FanWei. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MusicPlayerTool : NSObject


+ (instancetype)sharedPlayerTool;

- (void)playMusicWithMusicName:(NSString *)musicName;

- (void)pause;

@end
