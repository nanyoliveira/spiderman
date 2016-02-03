//
//  AOAPI.h
//  SpiderMan
//
//  Created by Ariane Oliveira on 01/12/2015.
//  Copyright © 2015 Ariane Oliveira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AOAPIProtocolListener.h"


@interface AOAPI : NSObject


@property (nonatomic, strong)id<AOAPIProtocolListener> listener ;
-(void)getMagazines;
-(void)getPictures;
-(void)getDetails;
+ (AOAPI*) sharedManager;

@end
