//
//  DetailsViewController.m
//  Instagram
//
//  Created by constanceh on 7/7/21.
//

#import "DetailsViewController.h"
#import "DateTools.h"
#import "ProfileViewController.h"
@import Parse;

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", @"HERE!");
    // Do any additional setup after loading the view.
    
    // Set username label
    PFUser *user = self.post[@"author"];
    if (user != nil) {
        // User found! update username label with username
        self.usernameLabel.text = [NSString stringWithFormat:@"@%@", user.username];
        self.userLabel.text = user.username;
    } else {
            // No user found, set default username
        self.usernameLabel.text = @"@default_name";
        self.userLabel.text = @"default_name";
    }
    
    // set timestamp label
    // Format and set createdAtString
    NSDate *createdAt = self.post.createdAt;
    // Convert Date to String using DateTool relative time
    self.timestampLabel.text = createdAt.shortTimeAgoSinceNow;
    
    // set post image
    self.postImage.file = self.post.image;
    [self.postImage loadInBackground];
    
    // make profile image view circular
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height /2;
    self.profileImage.layer.masksToBounds = YES;
    self.profileImage.layer.borderWidth = 0;
    
    // set profile image
    self.profileImage.layer.cornerRadius = 10;
    PFFileObject *profileImageFile = user[@"profileImage"];
    NSURL *url = [NSURL URLWithString: profileImageFile.url];
    NSData *fileData = [NSData dataWithContentsOfURL: url];
    self.profileImage.image = [[UIImage alloc] initWithData:fileData];
    
    // set caption label
    self.captionLabel.text = self.post.caption;
    
    // set like count
    NSString *likeCount = [NSString stringWithFormat:@"%@", self.post.likeCount];
    [self.likeButton setTitle:likeCount forState:UIControlStateNormal];
    NSLog(@"%@", self.post.liked);
    if (self.post.liked == @1) {
        [self.likeButton setSelected:YES];
    } else {
        [self.likeButton setSelected:NO];
    }
}

- (IBAction)onTapLike:(id)sender {
    // Unfavorite
        if (self.likeButton.isSelected) {
            // Update the local post model
            self.post.liked = @0;
            
            int value = [self.post.likeCount intValue];
            self.post.likeCount = [NSNumber numberWithInt:value - 1];

            // Update cell UI
            NSString *favCount = [NSString stringWithFormat:@"%@", self.post.likeCount];
            [self.likeButton setTitle:favCount forState:UIControlStateNormal];
            [self.likeButton setSelected:NO];

        // Favorite
        } else {
            // Update the local tweet model
            self.post.liked = @1;
            int value = [self.post.likeCount intValue];
            self.post.likeCount = [NSNumber numberWithInt:value + 1];

            // Update cell UI
            NSString *favCount = [NSString stringWithFormat:@"%@", self.post.likeCount];
            [self.likeButton setTitle:favCount forState:UIControlStateNormal];
            [self.likeButton setSelected:YES];
        }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"usernameDetailSegue"] || [[segue identifier] isEqualToString:@"userDetailSegue"] || [[segue identifier] isEqualToString:@"imageDetailSegue"]) {
        Post *post = self.post;
        ProfileViewController *profileController = [segue destinationViewController];
        profileController.user = post[@"author"];
    }
}

@end
