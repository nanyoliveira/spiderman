//
//  ViewController.h
//  SpiderMan
//
//  Created by Ariane Oliveira on 01/12/2015.
//  Copyright © 2015 Ariane Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AOAPIProtocolListener.h"
#import "BaseViewController.h"

@interface AOMagazineList : BaseViewController <AOAPIProtocolListener, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@end

