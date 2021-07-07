//
//  PostCell.m
//  Instagram
//
//  Created by constanceh on 7/7/21.
//

#import "PostCell.h"

@implementation PostCell

- (void)setPost:(Post *)post {
    _post = post;
    self.imageView.file = post[@"image"];
    [self.imageView loadInBackground];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
