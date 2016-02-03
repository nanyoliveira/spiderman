//
//  AOAPIProtocolListener.h
//  SpiderMan
//
//  Created by SBTUR Principal on 12/2/15.
//  Copyright © 2015 Ariane Oliveira. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AOAPIProtocolListener <NSObject>

- (void)notifyResult:(NSDictionary *)result withError:(NSError *)error;

@end
