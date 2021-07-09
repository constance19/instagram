//
//  ProfileViewController.h
//  Instagram
//
//  Created by constanceh on 7/8/21.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (nonatomic, strong) PFUser *user;

@end

NS_ASSUME_NONNULL_END
