//
//  Task.m
//  ToDoList
//
//  Created by Pulkit Goel on 8/9/13.
//  Copyright (c) 2013 Pulkit Goel. All rights reserved.
//

#import "Task.h"

@implementation Task


- (id) initWithToDoTask:(NSString *)taskDescription {
    self = [super init];
    
    if(self != nil){
        self.taskDescription = taskDescription;
    }
    
    return self;
}


@end




