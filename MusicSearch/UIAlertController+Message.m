//
//  UIAlertController+Message.m
//  MusicSearch
//
//  Created by Paul Ade on 2016-01-22.
//  Copyright © 2016 paulade. All rights reserved.
//

#import "UIAlertController+Message.h"

@implementation UIAlertController (Message)

+ (UIAlertController *)alertControllerWithTitle:(NSString *)titleString
                                        message:(NSString *)message
                                 preferredStyle:(UIAlertControllerStyle)preferredStyle
                                        actions:(UIAlertAction *)cancelAct, ... {
    va_list args;
    va_start(args, cancelAct);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleString
                                                                   message:message
                                                            preferredStyle:preferredStyle];
    
    for (UIAlertAction *action = cancelAct; action != nil; action = va_arg(args, UIAlertAction*))
    {
        [alert addAction:action];
    }
    va_end(args);
    return alert;
}

@end
