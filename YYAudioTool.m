//
//  YYAudioTool.m
//  sound-xyc
//
//  Created by geek on 14/12/20.
//  Copyright (c) 2014年 geek. All rights reserved.
//

#import "YYAudioTool.h"

@implementation YYAudioTool

/**
 *存放所有的音乐播放器
 */
static NSMutableDictionary *_musices;
+(NSMutableDictionary *)musices
{
    if (_musices==nil) {
        _musices=[NSMutableDictionary dictionary];
    }
    return _musices;
}
/**
 *存放一个的音乐播放器
 */
static NSMutableDictionary *_sound;
+(NSMutableDictionary *)sound
{
    if (_sound==nil) {
        _sound=[NSMutableDictionary dictionary];
    }
    return _sound;
}

/**
 *存放所有的音效ID
 */
static NSMutableDictionary *_soundIDs;
+(NSMutableDictionary *)soundIDs
{
    if (_soundIDs==nil) {
        _soundIDs=[NSMutableDictionary dictionary];
    }
    return _soundIDs;
}

/**
 *播放音乐
 */
+(BOOL)playMusic:(NSString *)filename ofName:(NSString *)name
{
    if (!name) return NO;//如果没有传入文件名，那么直接返回
    //1.取出对应的播放器
    AVAudioPlayer *player=[self musices][name];
    
    //2.如果播放器没有创建，那么就进行初始化
    if (!player) {
        //2.1音频文件的URL
        NSURL *url;
//      NSURL *url=[[NSBundle mainBundle]URLForResource:filename withExtension:nil];
//      NSURL *url=[NSURL URLWithString:filename];
        if(filename){
            url=[NSURL URLWithString:filename];
        }else{
            url=[[NSBundle mainBundle]URLForResource:filename withExtension:nil];
        }
//        NSLog(@"url====%@", url);
        if (!url) return NO;//如果url为空，那么直接返回
        //2.2创建播放器
        player=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        //2.3缓冲
        if (![player prepareToPlay]) return NO;//如果缓冲失败，那么就直接返回
        //2.4存入字典
        [self musices][name]=player;
    }
    //3.播放
    if (![player isPlaying]) {
        //如果当前没处于播放状态，那么就播放
        return [player play];
    }
    return YES;//正在播放，那么就返回YES
}
/**
 *播放音乐文件---新开的方法
 */
+(BOOL)playSound:(NSString *)filename ofName:(NSString *)name
{
    if (!name) return NO;//如果没有传入文件名，那么直接返回
    //1.取出对应的播放器
    AVAudioPlayer *player = [self sound][@"aac"];
    
    if (!player) {
        //2.如果播放器没有创建，
        //没有
    }else{
        //有就停止
        [player stop];
        //将播放器从字典中移除
        [[self musices] removeObjectForKey:@"aac"];
    }
    //那么就进行初始化
    //2.1音频文件的URL
    NSURL *url;
    if(filename){
        url=[NSURL URLWithString:filename];
    }else{
        url=[[NSBundle mainBundle]URLForResource:@"aac" withExtension:nil];
    }
//    NSLog(@"url====%@", url);
    if (!url) return NO;//如果url为空，那么直接返回
    //2.2创建播放器
    player=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    //2.3缓冲
    if (![player prepareToPlay]) return NO;//如果缓冲失败，那么就直接返回
    //2.4存入字典
    [self sound][@"aac"]=player;
    
    //3.播放
    if (![player isPlaying]) {
        //如果当前没处于播放状态，那么就播放
        return [player play];
    }
    return YES;//正在播放，那么就返回YES
}

+(void)pauseMusic:(NSString *)filename ofName:(NSString *)name
{
    if (!name) return;//如果没有传入文件名，那么就直接返回
    
    //1.取出对应的播放器
    AVAudioPlayer *player=[self musices][name];
    
    //2.暂停
    [player pause];//如果palyer为空，那相当于[nil pause]，因此这里可以不用做处理
}

+(void)pauseSound:(NSString *)filename ofName:(NSString *)name
{
    if (!name) return;//如果没有传入文件名，那么就直接返回
    
    //1.取出对应的播放器
    AVAudioPlayer *player=[self sound][@"aac"];
    
    //2.暂停
    [player pause];//如果palyer为空，那相当于[nil pause]，因此这里可以不用做处理
}

+(void)stopMusic:(NSString *)filename ofName:(NSString *)name
{
    if (!name) return;//如果没有传入文件名，那么就直接返回
    
    //1.取出对应的播放器
    AVAudioPlayer *player=[self musices][name];
    
    //2.停止
    [player stop];
    
    //3.将播放器从字典中移除
    [[self musices] removeObjectForKey:name];
}

//播放音效
+(void)playSound:(NSString *)filename
{
    if (!filename) return;
    //1.取出对应的音效
    SystemSoundID soundID=[[self soundIDs][filename] unsignedIntegerValue];
    
    //2.播放音效
    //2.1如果音效ID不存在，那么就创建
    if (!soundID) {
        //音效文件的URL
        NSURL *url=[[NSBundle mainBundle]URLForResource:filename withExtension:nil];
        if (!url) return;//如果URL不存在，那么就直接返回
        
        OSStatus status = AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
        NSLog(@"%ld", status);
        //存入到字典中
        [self soundIDs][filename]=@(soundID);
    }
//    NSLog(@"soundID=====%u", (unsigned int)soundID);
    //2.2有音效ID后，播放音效
    AudioServicesPlaySystemSound(soundID);
}

//销毁音效
+(void)disposeSound:(NSString *)filename
{
    //如果传入的文件名为空，那么就直接返回
    if (!filename) return;
    //1.取出对应的音效
    SystemSoundID soundID=[[self soundIDs][filename] unsignedIntegerValue];
    
    //2.销毁
    if (soundID) {
        AudioServicesDisposeSystemSoundID(soundID);
            
        //2.1销毁后，从字典中移除
        [[self soundIDs]removeObjectForKey:filename];
    }
}

@end
