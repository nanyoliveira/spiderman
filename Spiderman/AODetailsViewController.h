//
//  AODetailsViewController.h
//  SpiderMan
//
//  Created by SBTUR Principal on 12/2/15.
//  Copyright © 2015 Ariane Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AODetailsViewController : BaseViewController

@property (strong, nonatomic) NSDictionary* detailsData;


@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
@property (weak, nonatomic) IBOutlet UIWebView *mDescription;

@property (weak, nonatomic) IBOutlet UILabel *publishedText;
@property (weak, nonatomic) IBOutlet UILabel *priceText;
@property (weak, nonatomic) IBOutlet UILabel *pagesText;

@end
