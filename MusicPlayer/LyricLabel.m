//
//  LyricLabel.m
//  MusicPlayer
//
//  Created by 范伟 on 16/3/22.
//  Copyright © 2016年 FanWei. All rights reserved.
//

#import "LyricLabel.h"

@implementation LyricLabel

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [[UIColor greenColor] set];
    UIRectFillUsingBlendMode(CGRectMake(0, 0, rect.size.width * self.progress, rect.size.height), kCGBlendModeSourceIn);
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}
@end
