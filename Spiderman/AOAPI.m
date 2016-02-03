//
//  AOAPI.m
//  SpiderMan
//
//  Created by Ariane Oliveira on 01/12/2015.
//  Copyright © 2015 Ariane Oliveira. All rights reserved.
//

#import "AOAPI.h"
#import "AFHTTPRequestOperationManager.h"

#define SERVER_URL @"http://gateway.marvel.com:80/v1/public/characters/1009610/comics"

@interface AOAPI ()

@end

@implementation AOAPI

+ (AOAPI*) sharedManager
{
    static AOAPI *sharedApiManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedApiManager = [[AOAPI alloc] init];
    });
    return sharedApiManager;
}

-(void)getMagazines
{
      NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1", @"ts",@"bb4470a46d0659a43c566ac6056ed48d", @"apikey", @"479474cf0a28eac9998960da4d96f06b", @"hash",  nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:SERVER_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [self.listener notifyResult:responseObject withError: nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"An Error ocurred while loading the magazines: %@", error);
         [self.listener notifyResult:nil withError: error];
    }];
}

-(void)getPictures
{
    
}

-(void)getDetails
{
    
}


@end
