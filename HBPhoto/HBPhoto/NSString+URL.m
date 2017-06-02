//
//  NSString+URL.m
//  HBPhoto
//
//  Created by apple on 2017/5/16.
//  Copyright © 2017年 hebiao. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)


- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}
@end
