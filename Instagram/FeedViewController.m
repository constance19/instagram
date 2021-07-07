//
//  FeedViewController.m
//  Instagram
//
//  Created by constanceh on 7/6/21.
//

#import "FeedViewController.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "PostCell.h"
#import "DetailsViewController.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *arrayOfPosts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FeedViewController

- (IBAction)onTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        
        // Logout failed
        if (error) {
            NSLog(@"User logout failed: %@", error.localizedDescription);
        
        // Successful logout
        } else {
            NSLog(@"User logged out successfully!");
            SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            myDelegate.window.rootViewController = loginViewController;
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
        
    // Pull to refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl setTintColor:[UIColor blackColor]];
    [refreshControl addTarget:self action:@selector(loadPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    // Get timeline
    [self loadPosts];
}

- (void) loadPosts {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.arrayOfPosts = posts;
            [self.tableView reloadData];
        }
        else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    [self.refreshControl endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];

    Post *post = self.arrayOfPosts[indexPath.row];
    cell.post = post;
    cell.captionLabel.text = post.caption;
//    cell.imageView.file = post.image;

    PFUser *user = post[@"author"];
    if (user != nil) {
        // User found! update username label with username
        cell.usernameLabel.text = [NSString stringWithFormat:@"@%@", user.username];
    } else {
            // No user found, set default username
        cell.usernameLabel.text = @"@Default_Name";
    }


    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
//- (void)beginRefresh:(UIRefreshControl *)refreshControl {
//
//      // Create NSURL and NSURLRequest
//
//      NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
//                                                            delegate:nil
//                                                       delegateQueue:[NSOperationQueue mainQueue]];
//      session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//  
//      NSURLSessionDataTask *task = [session dataTaskWithRequest:request
//                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//  
//         // ... Use the new data to update the data source ...
//
//         // Reload the tableView now that there is new data
//          [self.tableView reloadData];
//
//         // Tell the refreshControl to stop spinning
//          [refreshControl endRefreshing];
//
//      }];
//  
//      [task resume];
//}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // For details view segue
    if ([[segue identifier] isEqualToString:@"detailViewSegue"]) {
        // Get the Post associated with the cell to bring to the details view
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.arrayOfPosts[indexPath.row];
            
        DetailsViewController *detailController = [segue destinationViewController];
        detailController.post = post;
    }
}

@end
