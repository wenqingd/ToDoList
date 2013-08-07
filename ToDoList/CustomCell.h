//
//  CustomCell.h
//  ToDoList
//
//  Created by Wenqing Dai on 8/6/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomCell;

@protocol CustomCellDelegate <NSObject>

- (void)customCell:(CustomCell*)cell textFieldReturn:(UITextField *)text;

@end

@interface CustomCell : UITableViewCell <UITextFieldDelegate>{

}

@property (nonatomic, weak) IBOutlet UITextField *toDoItem;
@property (nonatomic, weak) id<CustomCellDelegate> delegate;


@end
