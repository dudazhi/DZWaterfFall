//
//  ViewController.m
//  瀑布流
//
//  Created by 杜志 on 2017/7/23.
//  Copyright © 2017年 杜志. All rights reserved.
//

#import "ViewController.h"
#import "DZWaterLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,DZWaterLayoutDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DZWaterLayout * flowLayout = [[DZWaterLayout alloc]init];
    flowLayout.delegate = self;
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collectionView];
    
    
}

#pragma mark - <collectiondelegate>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell  * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}
#pragma mark - <DZWaterLayoutDelegate>
-(NSInteger)numberOfColumInLayout:(DZWaterLayout *)layout
{
    return 2;
}
-(CGFloat)DZWaterLayout:(DZWaterLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath ItemWidth:(CGFloat)ItemWidth
{
    return 50+arc4random_uniform(100);
}
@end
