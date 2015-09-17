//
//  Joke.h
//  XiaoHaha
//
//  Created by macAir on 15/9/17.
//  Copyright (c) 2015年 ZhouBei. All rights reserved.
//  笑话模型

#import <Foundation/Foundation.h>

@interface Joke : NSObject
/*
 "ct": "2015-08-13 13:10:36.891",
 "img": "http://img.hao123.com/data/3_1b72caa7998cf674fecb4f334cf9d356_430",
 "title": "牙膏还有这技能。",
 "type": 2
 */
/** ct 创建时间 */
@property (nonatomic, copy) NSString *ct;

/** img 笑话图片 */
@property (nonatomic, copy) NSString *img;

/** title 笑话标题 */
@property (nonatomic, copy) NSString *title;
@end
