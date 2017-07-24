//
//  DZWaterLayout.h
//  瀑布流
//
//  Created by 杜志 on 2017/7/23.
//  Copyright © 2017年 杜志. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DZWaterLayout;

//通过代理，在外界设置列数，内边距以及cell的高度
@protocol DZWaterLayoutDelegate<NSObject>
@required
-(CGFloat)DZWaterLayout:(DZWaterLayout*)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath ItemWidth:(CGFloat)ItemWidth;
@optional
-(NSInteger)numberOfColumInLayout:(DZWaterLayout*)layout;
-(CGFloat)columMarginInLayout:(DZWaterLayout*)layout;
-(CGFloat)rowMarginInLayout:(DZWaterLayout*)layout;
-(UIEdgeInsets)EdgeInsetInLayout:(DZWaterLayout*)layout;
@end

@interface DZWaterLayout : UICollectionViewLayout
@property(nonatomic,strong)NSMutableArray * array;
/*所有列的高度*/
@property(nonatomic,strong)NSMutableArray * maxHeights;

@property(nonatomic,strong)id<DZWaterLayoutDelegate>delegate;

-(NSInteger)Colum;
-(CGFloat)columMargin;
-(CGFloat)rowMargin;
-(UIEdgeInsets)EdgeInset;

@end
