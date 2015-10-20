//
//  YYAudioTool.h
//  sound-xyc
//
//  Created by geek on 14/12/20.
//  Copyright (c) 2014年 geek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface YYAudioTool : NSObject
/**
 *播放音乐文件
 */
+(BOOL)playMusic:(NSString *)filename ofName:(NSString *)name;
/**
 *播放音乐文件---给微拍单独使用
 */
+(BOOL)playSound:(NSString *)filename ofName:(NSString *)name;
/**
 *暂停播放
 */
+(void)pauseMusic:(NSString *)filename ofName:(NSString *)name;
/**
 *暂停播放---给微拍单独使用
 */
+(void)pauseSound:(NSString *)filename ofName:(NSString *)name;
/**
 *停止播放音乐文件
 */
+(void)stopMusic:(NSString *)filename ofName:(NSString *)name;

/**
 *播放音效文件
 */
+(void)playSound:(NSString *)filename;
/**
 *销毁音效
 */
+(void)disposeSound:(NSString *)filename;

@end
