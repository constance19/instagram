//
//  DetailsViewController.m
//  Instagram
//
//  Created by constanceh on 7/7/21.
//

#import "DetailsViewController.h"
#import "DateTools.h"
@import Parse;

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet PFImageView *postImage;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set username label
    PFUser *user = self.post[@"author"];
    if (user != nil) {
        // User found! update username label with username
        self.usernameLabel.text = [NSString stringWithFormat:@"@%@", user.username];
    } else {
            // No user found, set default username
        self.usernameLabel.text = @"@Default_Name";
    }
    
    // set timestamp label
    // Format and set createdAtString
    NSDate *createdAt = self.post.createdAt;
    // Convert Date to String using DateTool relative time
    self.timestampLabel.text = createdAt.shortTimeAgoSinceNow;
    
    // set post image
    self.postImage.file = self.post.image;
    [self.postImage loadInBackground];
    
    // set caption label
    self.captionLabel.text = self.post.caption;
    
    // set like count
    NSString *likeCount = [NSString stringWithFormat:@"%@", self.post.likeCount];
    [self.likeButton setTitle:likeCount forState:UIControlStateNormal];
}

- (IBAction)onTapLike:(id)sender {
    // Unfavorite
        if (self.likeButton.isSelected) {
            // Update the local post model
//            self.post.liked = FALSE;
            
            int value = [self.post.likeCount intValue];
            self.post.likeCount = [NSNumber numberWithInt:value - 1];

            // Update cell UI
            NSString *favCount = [NSString stringWithFormat:@"%@", self.post.likeCount];
            [self.likeButton setTitle:favCount forState:UIControlStateNormal];
            [self.likeButton setSelected:NO];

        // Favorite
        } else {
            // Update the local tweet model
//            self.post.liked = TRUE;
            int value = [self.post.likeCount intValue];
            self.post.likeCount = [NSNumber numberWithInt:value + 1];

            // Update cell UI
            NSString *favCount = [NSString stringWithFormat:@"%@", self.post.likeCount];
            [self.likeButton setTitle:favCount forState:UIControlStateNormal];
            [self.likeButton setSelected:YES];
        }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
