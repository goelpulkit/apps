//
//  Task.h
//  ToDoList
//
//  Created by Pulkit Goel on 8/9/13.
//  Copyright (c) 2013 Pulkit Goel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (nonatomic, strong) NSString *taskDescription;

- (id) initWithToDoTask:(NSString *)taskDescription;

@end
