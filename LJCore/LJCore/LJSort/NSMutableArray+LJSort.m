//
//  NSMutableArray+LJSort.m
//  LJCore
//
//  Created by sf on 2018/4/8.
//  Copyright © 2018年 Yaphets. All rights reserved.
//

#import "NSMutableArray+LJSort.h"

@interface NSMutableArray ()
@property(nonatomic, copy) LJSortComparator comparator;
@property(nonatomic, strong) id objc;
@end

@implementation NSMutableArray (LJSort)

- (void)lj_sortUsingComparator:(LJSortComparator)comparator sortType:(LJSortType)sortType {
    self.comparator = comparator;
    switch (sortType) {
        case LJSelectionSort:
            [self lj_selectionSort];
            break;
        case LJBubbleSort:
            [self lj_bubbleSort];
        case LJInsertionSort:
            [self lj_insertionSort];
        default:
            break;
    }
}
#pragma mark - 私有排序算法
//交换两个元素
- (void)lj_exchangeWithIndexA:(NSInteger)indexA indexB:(NSInteger)indexB {
    if (indexA >= self.count || indexB >= self.count) {
        NSLog(@"indexA:%ld,indexB:%ld",indexA,indexB);
        return;
    }
    id temp = self[indexA];;
    self[indexA] = self[indexB];
    self[indexB] = temp;
}
#pragma mark - /**选择排序**/
- (void)lj_selectionSort {
    for (int i = 0; i < self.count; i++) {
        for (int j = i + 1; self.count; j++) {
            if (self.comparator(self[i],self[j]) == NSOrderedDescending) {
                [self lj_exchangeWithIndexA:i indexB:j];
            }
        }
    }
}

#pragma mark - /**冒泡排序**/
- (void)lj_bubbleSort {
    bool swapped;
    do {
        swapped = false;
        for (int i = 1; i < self.count; i++) {
            if (self.comparator(self[i],self[i - 1]) == NSOrderedDescending) {
                swapped = true;
                [self lj_exchangeWithIndexA:i indexB:i - 1];
            }
        }
    } while (swapped);
}

#pragma mark - /**插入排序**/
- (void)lj_insertionSort {
    
}
@end
