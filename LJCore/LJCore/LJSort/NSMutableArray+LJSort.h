//
//  NSMutableArray+LJSort.h
//  LJCore
//
//  Created by sf on 2018/4/8.
//  Copyright © 2018年 Yaphets. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LJSortType) {
    LJSelectionSort,   //选择排序
    LJBubbleSort,   //冒泡排序
    LJInsertionSort,  //插入排序
    LJMergeSort,  //归并排序
    LJQuickSort,   //原始快速排序
    LJIdenticalQuickSort,   //双录快速排序
    LJQuick3WaysSort,  //三路快速排序
    LJHeapSort,   //堆排序
};

typedef NSComparisonResult(^LJSortComparator)(id obj1, id obj2);

@interface NSMutableArray (LJSort)

- (void)lj_sortUsingComparator:(LJSortComparator)comparator sortType:(LJSortType )sortType;

- (void)lj_exchangeWithIndexA:(NSInteger)indexA indexB:(NSInteger)indexB;
@end
