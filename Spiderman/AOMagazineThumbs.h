//
//  AOMagazineThumbs.h
//  SpiderMan
//
//  Created by SBTUR Principal on 12/2/15.
//  Copyright © 2015 Ariane Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AOMagazineThumbs : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *editionNumber;
@property (strong, nonatomic) NSDictionary* thumbData;

-(void) setCollectionCell;
@end
