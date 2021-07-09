//
//  DetailsViewController.h
//  Instagram
//
//  Created by constanceh on 7/7/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

//@protocol DetailsViewControllerDelegate
//@end

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) Post *post;
//@property (nonatomic, weak) id<DetailsViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
