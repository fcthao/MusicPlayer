//
//  LyricTool.m
//  MusicPlayer
//
//  Created by 范伟 on 16/3/22.
//  Copyright © 2016年 FanWei. All rights reserved.
//

#import "MusicLyricTool.h"
#import "MusicLyric.h"

@implementation MusicLyricTool

+ (NSArray<MusicLyric *> *)allLyricLinesWithLyricName:(NSString *)lyricName {
    NSMutableArray *lyrics = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:lyricName ofType:nil];
    if (!path) {
        NSAssert(path != nil, @"歌词文件不存在！");
        return nil;
    }
    NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray<NSString*> *lyricLines = [text componentsSeparatedByString:@"\n"];
    for (NSString *line in lyricLines) {
        //[02:55.00][00:58.00]为何只是失望填密我的空虚
        NSString *pattern = @"\\[\\d{2}:\\d{2}\\.\\d{2}\\]";
        NSError *error = nil;
        NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
        if (error != nil) {
////            NSAssert(error != nil, [NSString stringWithFormat:@"%@", error])
//            NSString *s = [NSString stringWithFormat:@"%@", error];
//            NSAssert(error != nil, s);
            return nil;
        }
        NSArray<NSTextCheckingResult *> *matchingResult = [regEx matchesInString:line options:NSMatchingReportCompletion range:NSMakeRange(0, line.length)];
        NSTextCheckingResult *result = [matchingResult lastObject];
        //取出一行中的歌词
        NSString *lyricText = [line substringFromIndex:result.range.location + result.range.length];
        //创建歌词模型
        for (NSTextCheckingResult *result in matchingResult) {
            //取出时间
            NSString *time = [line substringWithRange:result.range];
            MusicLyric *lyric = [[MusicLyric alloc] init];
            [lyric setLyricText:lyricText];
            
            //00:58.00 字符串时间转为以秒表示的数字
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"[mm:ss.SS]"];
            NSDate *date = [formatter dateFromString:time];
            NSDate *zeroDate = [formatter dateFromString:@"[00:00.00]"];
            
            [lyric setTimePoint:[date timeIntervalSinceDate:zeroDate]];//利用某个时间与0时间之间的差值方法求出
            [lyrics addObject:lyric];
        }
    }
    //给数组中的元素按时间进行排序
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"timePoint" ascending:true];
    return [lyrics sortedArrayUsingDescriptors:@[descriptor]];
}
@end
