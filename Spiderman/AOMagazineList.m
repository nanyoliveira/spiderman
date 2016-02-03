//
//  ViewController.m
//  SpiderMan
//
//  Created by Ariane Oliveira on 01/12/2015.
//  Copyright © 2015 Ariane Oliveira. All rights reserved.
//

#import "AOMagazineList.h"
#import "AOAPI.h"
#import "AOMagazineThumbs.h"
#import "AODetailsViewController.h"

@interface AOMagazineList ()

@property (nonatomic, strong) NSArray * resources;
@property (nonatomic, strong) NSString * copyrights;
@property (nonatomic) int totalResources;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UILabel *copyrightsLabel;
@property (strong, nonatomic) AOMagazineThumbs * selectedCell;

@end

@implementation AOMagazineList

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.totalResources = 0;
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.totalResources = 0;
    [AOAPI sharedManager].listener = self;
    [[AOAPI sharedManager] getMagazines];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_marvel_logo"]];
    
    [[self.navigationController navigationBar] setBackgroundColor:[UIColor blackColor]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}

- (void)dealloc
{
    [AOAPI sharedManager].listener = nil;
}


- (void)notifyResult:(NSDictionary *)result withError:(NSError *)error
{
    if(error == nil && result !=nil)
    {
        self.copyrights = [NSString stringWithFormat:@"Data provided by Marvel. %@", result[@"copyright"]];
        self.totalResources = (int) result[@"data"][@"count"];
        self.resources = result[@"data"][@"results"];
       
        [self.collection reloadData];
        self.copyrightsLabel.text = self.copyrights;
    }
    
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.resources count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AOMagazineThumbs *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
     cell.thumbData= self.resources[indexPath.row];
    [cell setCollectionCell];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCell = (AOMagazineThumbs *)[collectionView cellForItemAtIndexPath:indexPath];
     [self performSegueWithIdentifier:@"show Details" sender:self];
}


#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize retval =  CGSizeMake(100, 120);
    retval.height += 30;
    retval.width += 10;
    return retval;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(30, 20, 30, 20);
}


#pragma mark – Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"show Details"]) {
        AODetailsViewController * vc = (AODetailsViewController *) [segue destinationViewController] ;
        vc.detailsData = self.selectedCell.thumbData;
    }
}

@end
