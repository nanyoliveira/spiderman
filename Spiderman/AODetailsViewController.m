//
//  AODetailsViewController.m
//  SpiderMan
//
//  Created by SBTUR Principal on 12/2/15.
//  Copyright © 2015 Ariane Oliveira. All rights reserved.
//

#import "AODetailsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define nilOrJSONObjectForKey(JSON_, KEY_) [[JSON_ objectForKey:KEY_] isKindOfClass:[NSNull class]] ? nil : [JSON_ objectForKey:KEY_]

@implementation AODetailsViewController

-(void)viewDidLoad {
   [super viewDidLoad];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
     [self showdetaisl];
}

#pragma Showing Data

-(void)showdetaisl {
    
    self.mTitle.text = nilOrJSONObjectForKey(self.detailsData, @"title");
    NSArray * images = nilOrJSONObjectForKey(self.detailsData, @"images");
    [self setDetailsImagesFromArray:images];
    [self setDescription];
    [self setPublishedDate];
    [self setPrices];
    
    self.pagesText.text = [NSString stringWithFormat:@"%@", nilOrJSONObjectForKey(self.detailsData, @"pageCount")];
}



-(void) setDetailsImagesFromArray:(NSArray *) imagesCollection {
   if ([imagesCollection count] > 0) {
        if([imagesCollection[0] isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary * coverImageData = (NSDictionary *) imagesCollection[0];
            NSString * path = nilOrJSONObjectForKey(coverImageData, @"path");
            NSString * extension = nilOrJSONObjectForKey(coverImageData, @"extension");
            if(path != nil && extension !=nil){
                NSString * imagePath = [NSString stringWithFormat:@"%@/portrait_uncanny.%@", path, extension];
                
                [self.topImage sd_setImageWithURL:[NSURL URLWithString:imagePath]
                                   placeholderImage:[UIImage imageNamed:@"loading.png"]];
                
                
                [[self.profileImage layer] setBorderWidth:4.0f];
                [[self.profileImage layer] setBorderColor:[UIColor whiteColor].CGColor];
                
                [self.profileImage sd_setImageWithURL:[NSURL URLWithString:imagePath]
                                 placeholderImage:[UIImage imageNamed:@"loading.png"]];
            }
        }
    }
}

-(void)setDescription {
    NSString * descriptionText =  nilOrJSONObjectForKey(self.detailsData, @"description");
    NSString * htmlText = [NSString stringWithFormat:@"<body style=\"background:transparent;color: white;font: sans-serif 14\"> %@</body>", descriptionText];
    [self.mDescription setBackgroundColor:[UIColor clearColor]];
    [self.mDescription loadHTMLString:htmlText baseURL:nil];
    
}

-(void) setPublishedDate {
    NSArray * dates = nilOrJSONObjectForKey(self.detailsData, @"dates");
    for (NSDictionary * dic in dates) {
        if([dic [@"type"] isEqualToString:@"onsaleDate"]) {
            NSString * fullDateString = dic[@"date"];
            NSString * dateString = [fullDateString substringWithRange:NSMakeRange(0, 10)];
            NSDate * date = [self parseDate:dateString];
            NSArray * months = [[NSArray alloc] initWithObjects:@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November",@"December", nil];
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
            NSString * customizesDate = [NSString stringWithFormat:@"%@ %ld, %ld", months[[components month]-1], (long)[components day], (long)[components year]];
            self.publishedText.text = customizesDate;
        }
    }
}

- (NSDate*)parseDate:(NSString*)inStrDate {
    NSDateFormatter* dtFormatter = [[NSDateFormatter alloc] init];
    [dtFormatter setLocale:[NSLocale systemLocale]];
    [dtFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* dateOutput = [dtFormatter dateFromString:inStrDate];
    return dateOutput;
}



-(void)setPrices {
    NSArray * prices = nilOrJSONObjectForKey(self.detailsData, @"prices");
    for (NSDictionary * dic in prices) {
        if([dic [@"type"] isEqualToString:@"printPrice"]) {
             self.priceText.text = [NSString stringWithFormat:@" %@",dic[@"price"]];
        }
    }
}
@end
