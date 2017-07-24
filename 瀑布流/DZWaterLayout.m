//
//  DZWaterLayout.m
//  瀑布流
//
//  Created by 杜志 on 2017/7/23.
//  Copyright © 2017年 杜志. All rights reserved.
//

#import "DZWaterLayout.h"

/*默认列数*/
static const NSInteger DZDefaultColum = 3;
/*每一列之间的间距*/
static const CGFloat DZDefaultColumMargin = 10;
/*每一行之间的间距*/
static const CGFloat DZDefaultRowMargin = 10;
/*边缘间距*/
static const UIEdgeInsets  DZDefaultEdgeInset = {10,10,10,10};

@implementation DZWaterLayout
//懒加载
-(NSInteger)Colum{
    if ([self.delegate respondsToSelector:@selector(numberOfColumInLayout:)]) {
        return [self.delegate numberOfColumInLayout:self];
    }else{
        return DZDefaultColum;
    }
}
-(CGFloat)columMargin{
    if ([self.delegate respondsToSelector:@selector(columMarginInLayout:)]) {
        return [self.delegate columMarginInLayout:self];
    }else{
        return DZDefaultColumMargin;
    }
}
-(CGFloat)rowMargin{
    if ([self.delegate respondsToSelector:@selector(rowMarginInLayout:)]) {
        return [self.delegate rowMarginInLayout:self];
    }else
    {
        return DZDefaultRowMargin;
    }
}
-(UIEdgeInsets)EdgeInset{
    if ([self.delegate respondsToSelector:@selector(EdgeInsetInLayout:)]) {
        return [self.delegate EdgeInsetInLayout:self];
    }else
    {
        return DZDefaultEdgeInset;
    }
}
-(NSMutableArray *)maxHeights{
    if (!_maxHeights) {
        _maxHeights = [NSMutableArray array];
    }
    return _maxHeights;
}
//初始化
-(void)prepareLayout
{
    [super prepareLayout];
    //清楚数据
    [self.maxHeights removeAllObjects];
    for (NSInteger i =0; i<self.Colum; i++) {
        [self.maxHeights addObject:@(self.EdgeInset.top)];
    }

    [self.array removeAllObjects];
    self.array = [[NSMutableArray alloc]init];
    //开始每一个cell的布局
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i<count; i++) {
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //获取布局属性
        UICollectionViewLayoutAttributes * atrr = [self layoutAttributesForItemAtIndexPath:indexPath];
        //添加到数组中
        [self.array addObject:atrr];
    }

}
//决定cell的排布
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
   
    return self.array;
}
//indexpath所在的cell的布局属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //创建布局属性
    UICollectionViewLayoutAttributes * atrr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //设置属性
    //找出最短的那一列属性
   NSInteger destColum = 0;
   CGFloat destValue = [self.maxHeights[0] doubleValue];
    for (NSInteger i =1; i<self.Colum; i++) {
         CGFloat cellHeight =[self.maxHeights[i] doubleValue];
        if (destValue>cellHeight) {
            destValue = cellHeight;
            destColum = i;
        }
    }
    CGFloat collectionWidth = self.collectionView.frame.size.width;
    CGFloat width = (collectionWidth-self.EdgeInset.left-self.EdgeInset.right-(self.Colum-1)*self.columMargin)/self.Colum;
    CGFloat x = self.EdgeInset.left+destColum*(width+self.columMargin);
    CGFloat y = destValue+self.rowMargin;
    if (indexPath.item/3<2) {
        y = self.rowMargin;
    }
  
    CGFloat height = [self.delegate DZWaterLayout:self heightForItemAtIndexPath:indexPath ItemWidth:width];
    atrr.frame = CGRectMake(x, y,width, height);
    //更新最短那列的高度
    self.maxHeights[destColum] = @(CGRectGetMaxY(atrr.frame));
    return atrr;
}

-(CGSize)collectionViewContentSize
{
    
    CGFloat maxHeight = [self.maxHeights[0] doubleValue];
    for (NSInteger i =1; i<self.Colum; i++) {
        CGFloat cellHeight =[self.maxHeights[i] doubleValue];
        if (maxHeight<cellHeight) {
            maxHeight = cellHeight;
        }
    }
    return CGSizeMake(0, maxHeight+self.EdgeInset.bottom);
}
@end
