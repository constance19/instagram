//
//  DetailsViewController.m
//  Instagram
//
//  Created by constanceh on 7/7/21.
//

#import "DetailsViewController.h"
@import Parse;

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet PFImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

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
    
    // set post image
    self.imageView.file = self.post.image;
    [self.imageView loadInBackground];
    
    // set caption label
    self.captionLabel.text = self.post.caption;
    
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
