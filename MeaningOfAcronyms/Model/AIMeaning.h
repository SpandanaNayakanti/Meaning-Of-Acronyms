//
//  AIMeaning.h
//  Acronym
//
//  Created by spandana nayakanti on 12/18/16.
//  Copyright (c) 2016 spandana nayakanti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIMeaning : NSObject
@property (nonatomic, copy) NSString *meaning;
@property NSInteger frequency;
@property NSInteger since;
@property (nonatomic, copy) NSMutableArray *variations;

@end
