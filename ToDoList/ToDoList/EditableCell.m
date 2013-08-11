//
//  EditableCell.m
//  ToDoList
//
//  Created by Pulkit Goel on 8/10/13.
//  Copyright (c) 2013 Pulkit Goel. All rights reserved.
//

#import "EditableCell.h"

@implementation EditableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
