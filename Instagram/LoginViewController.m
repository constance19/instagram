//
//  LoginViewController.m
//  Instagram
//
//  Created by constanceh on 7/6/21.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "ProfileViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Round corners of login button
    self.loginButton.layer.cornerRadius = 3.5;
    self.loginButton.clipsToBounds = YES;
    
    // Set placeholder text of username and password text fields
    self.usernameField.placeholder = @"Phone number, username, or email";
    self.passwordField.placeholder = @"Password";
}

- (IBAction)onTapSignup:(id)sender {
    if([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incomplete information!"
                                                                       message:@"Please fill out all text fields!"
                                                                preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                     // handle response here.
            
        }];
        
        // add the OK action to the alert controller
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
        
        }];
    }
    [self registerUser];
}

- (IBAction)onTapLogin:(id)sender {
    if([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incomplete information!"
                                                                           message:@"Please fill out all text fields!"
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
        
            // create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                     // handle response here.
            }];
        
            // add the OK action to the alert controller
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
            }];
        }
        [self loginUser];
}

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
//    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        // Error signing up
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid username!"
                                                                           message:@"Enter valid username!"
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
                        
                            // create an OK action
                            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                               style:UIAlertActionStyleDefault
                                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                                     // handle response here.
                                                                             }];
                            // add the OK action to the alert controller
                            [alert addAction:okAction];
                            [self presentViewController:alert animated:YES completion:^{
                                // optional code for what happens after the alert controller has finished presenting
                            }];
        
        // Successful sign up
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"loginSegue" sender:self.signupButton];
        }
    }];
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        
        // Error logging in
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid username/password!"
                                                                           message:@"Enter valid username and password!"
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
                        
                            // create an OK action
                            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                               style:UIAlertActionStyleDefault
                                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                                     // handle response here.
                                                                             }];
                            // add the OK action to the alert controller
                            [alert addAction:okAction];
                            [self presentViewController:alert animated:YES completion:^{
                                // optional code for what happens after the alert controller has finished presenting
                            }];
        
        // Successful log in
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"loginSegue" sender:self.loginButton];
        }
    }];
}

//- (void)passDataForward
//{
//    ProfileViewController *profilePage = [[ProfileViewController alloc] initWithNib:@"profilePage" bundle:nil];
//    profilePage.username = self.usernameField.text;
////    [self pushViewController:viewControllerB animated:YES];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
