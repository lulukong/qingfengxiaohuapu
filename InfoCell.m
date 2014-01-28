//
//  InfoCell.m
//  xiaohuapu
//
//  Created by lulu on 14-1-10.
//  Copyright (c) 2014年 dianjoy. All rights reserved.
//

#import "InfoCell.h"
#import "NSString+HTML.h"

@implementation InfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        backgroundView = [[[NSBundle mainBundle] loadNibNamed:@"InfoCell" owner:self options:nil] objectAtIndex:0];
        [backgroundImageView setImage:[[UIImage imageNamed:@"cell.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20,20,20)]];
        [self addSubview:backgroundView];
        self.backgroundColor = [UIColor colorWithRed:233/255.0 green:220/255.0 blue:201/255.0 alpha:1.0f];
    }
    return self;
}
-(void)sethidden
{
    backgroundImageView.hidden  =YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(float)height:(NSDictionary *)info
{
    float height = 20;
    NSString *text = [[info objectForKey:@"con"] stringByConvertingHTMLToPlainText];
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(280, MAXFLOAT)];
    height += size.height;

    return height + 60;
}

-(void) setInfo:(NSDictionary *)info
{
    float height = 20;
    line.backgroundColor = [UIColor lightGrayColor];
    
    NSString *text = [[info objectForKey:@"con"] stringByConvertingHTMLToPlainText];
    [contentLabel setText:text];
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(280, MAXFLOAT)];
    [contentLabel setFrame:CGRectMake(contentLabel.frame.origin.x,60, size.width, size.height)]; //contentLabel.frame.origin.y
    
    NSString *name = [info objectForKey:@"author"];
    CGSize size1 = [name sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(150, 30)];
    nameLabel.text = name;
    
    NSString *time = [info objectForKey:@"date"];
    [time sizeWithFont:[UIFont systemFontOfSize:5.0f] constrainedToSize:CGSizeMake(80, 30)];
    timelabel.text = time;
    
    height = size.height + size1.height;
    
    CGRect frame = backgroundImageView.frame;
    frame.size.height = height + 50;
//    [backgroundImageView setFrame:frame];
//    [backgroundImageView setFrame:CGRectMake(10, 6, frame.size.width-20, frame.size.height)];
    [backgroundImageView setFrame:CGRectMake(10, 6, 300, frame.size.height)];
}

-(void)dealloc
{
    [contentLabel release];
    [backgroundImageView release];
    [super dealloc];
}

@end

