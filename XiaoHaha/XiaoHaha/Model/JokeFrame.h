//
//  JokeFrame.h
//  XiaoHaha
//
//  Created by macAir on 15/9/17.
//  Copyright (c) 2015年 ZhouBei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Joke;

@interface JokeFrame : NSObject

@property (nonatomic, strong) Joke *joke;

/** ct 创建时间 */
@property (nonatomic, assign) CGRect ctF;

/** img 笑话图片 */
@property (nonatomic, assign) CGRect imgF;

/** title 笑话标题 */
@property (nonatomic, assign) CGRect titleF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
