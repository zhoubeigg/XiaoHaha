//
//  JokeCell.m
//  XiaoHaha
//
//  Created by macAir on 15/9/17.
//  Copyright (c) 2015年 ZhouBei. All rights reserved.
//

#import "JokeCell.h"
#import "UIImageView+WebCache.h"
#import "Joke.h"

@interface JokeCell()
/** ct 创建时间 */
@property (nonatomic, weak) UILabel *timeLabel;

/** img 笑话图片 */
@property (nonatomic, weak) UIImageView *imgView;

/** title 笑话标题 */
@property (nonatomic, weak) UILabel *titleLabel;
@end

@implementation JokeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"joke";
    JokeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[JokeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次，在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 初始一条笑话
        [self setupJoke];
        
    }
    return  self;
}

- (void)setupJoke
{
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = [UIColor orangeColor];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:imgView];
    self.imgView = imgView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
}

- (void)setJoke:(Joke *)joke
{
    _joke = joke;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    CGFloat contenX = 10.0;
    CGFloat imageWH = 300;
    
    self.titleLabel.frame = CGRectMake(contenX, 20, cellW, 20);
    self.titleLabel.text = joke.title;
    
    self.timeLabel.frame = CGRectMake(contenX, 45, cellW, 20);
    self.timeLabel.text = joke.ct;
    
    self.imgView.frame = CGRectMake((cellW - imageWH)*0.5, 80, imageWH, imageWH);
    NSURL *imgUrl = [NSURL URLWithString:joke.img];
    [self.imgView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"holder"]];
}

@end
