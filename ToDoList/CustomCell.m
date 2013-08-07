//
//  CustomCell.m
//  ToDoList
//
//  Created by Wenqing Dai on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize delegate;

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

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UITextField *copyTest = [[UITextField alloc] init];
    copyTest = textField;
    
    if ([delegate respondsToSelector:@selector(customCell:textFieldReturn:)]) {
        [delegate customCell:self textFieldReturn:textField];
    }
    textField.text = @"";
    return YES;
}


@end
