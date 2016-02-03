//
//  AOMagazineThumbs.m
//  SpiderMan
//
//  Created by SBTUR Principal on 12/2/15.
//  Copyright © 2015 Ariane Oliveira. All rights reserved.
//

#import "AOMagazineThumbs.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define nilOrJSONObjectForKey(JSON_, KEY_) [[JSON_ objectForKey:KEY_] isKindOfClass:[NSNull class]] ? nil : [JSON_ objectForKey:KEY_]

@interface AOMagazineThumbs ()

@end

@implementation AOMagazineThumbs

-(void) setCollectionCell
{
    
    [self thumbFill: nilOrJSONObjectForKey(self.thumbData, @"thumbnail")];
    [self issueNumberFill:  nilOrJSONObjectForKey(self.thumbData, @"issueNumber")];
}

-(void)thumbFill:(NSDictionary *)thumbImageData
{
  if(thumbImageData != nil)
  {
      NSString * path = nilOrJSONObjectForKey(thumbImageData, @"path");
      NSString * extension = nilOrJSONObjectForKey(thumbImageData, @"extension");
      
      if(path != nil && extension !=nil){
           NSString * imagePath = [NSString stringWithFormat:@"%@/portrait_xlarge.%@", path, extension];
          
          [self.coverImage sd_setImageWithURL:[NSURL URLWithString:imagePath]
                            placeholderImage:[UIImage imageNamed:@"loading.png"]];
          
        }
     
  }
}

-(void)issueNumberFill:(id)issueNumber
{
    if(issueNumber != nil)
    {
        self.editionNumber.text = [NSString stringWithFormat:@"# %@",issueNumber];
    }
}

@end
