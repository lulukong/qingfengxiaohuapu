//
//  InfoCell.h
//  xiaohuapu
//
//  Created by lulu on 14-1-10.
//  Copyright (c) 2014年 dianjoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoCell : UITableViewCell
{
    IBOutlet UILabel *contentLabel;
    IBOutlet UIImageView *backgroundImageView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *timelabel;
    IBOutlet UIImageView *headImage;
    IBOutlet UIImageView *line;
    
    UIView *backgroundView;
}

+(float)height:(NSDictionary *)info;
-(void) setInfo:(NSDictionary *)info;
-(void) sethidden;


@end
