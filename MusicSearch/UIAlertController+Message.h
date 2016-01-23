//
//  UIAlertController+Message.h
//  MusicSearch
//
//  Created by Paul Ade on 2016-01-22.
//  Copyright © 2016 paulade. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  <#Description#>
 */
@interface UIAlertController (Message)
+ ( UIAlertController * _Nonnull )alertControllerWithTitle:(nullable NSString *)titleString
                                        message:(nullable NSString *)message
                                            preferredStyle:(UIAlertControllerStyle)preferredStyle
                                                   actions:( UIAlertAction * _Nonnull )cancelAct,...;

@end
