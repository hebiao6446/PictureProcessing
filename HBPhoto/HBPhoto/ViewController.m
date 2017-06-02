//
//  ViewController.m
//  HBPhoto
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 hebiao. All rights reserved.
//

#import "ViewController.h"

#import "NSString+URL.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, 700, 500);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    size1 = CGSizeMake(750, 1000);
    size2 = CGSizeMake(750, 750);
    size3 = CGSizeMake(750, 562.5);
    
    ////  1  750 X 1130  ; 2  750 X 750 ; 3 750 X 546
    chuliLeixing = 1;
    
    shuruString = [[NSMutableString alloc] init];
    shuchuString = [[NSMutableString alloc] init];
    
    
    
    
    
    
    
    
    NSButton *button = [[NSButton alloc] init];
    button.frame = CGRectMake(20, 490, 150, 50);
    [button setTitle:@"选择图片的输入目录"];
    [button setTarget:self];
    [button setAction:@selector(action1:)];
    [self.view addSubview:button];
    
    
    
    shuruMulu = [[NSTextField alloc] init];
    shuruMulu.frame = CGRectMake(200, 500, 250, 30);
    [shuruMulu setBezeled:NO];
    shuruMulu.stringValue = @"图片输入文件夹路径";
    [shuruMulu setDrawsBackground:NO];
    [shuruMulu setEditable:NO];
    [shuruMulu setSelectable:NO];
    [self.view addSubview:shuruMulu];
    
    
    
    tupianShulinag = [[NSTextField alloc] init];
    tupianShulinag.frame = CGRectMake(500, 500, 250, 30);
    [tupianShulinag setBezeled:NO];
    tupianShulinag.stringValue = @"";
    [tupianShulinag setDrawsBackground:NO];
    [tupianShulinag setEditable:NO];
    [tupianShulinag setSelectable:NO];
    [self.view addSubview:tupianShulinag];
    
    
    
    
    button = [[NSButton alloc] init];
    button.frame = CGRectMake(20, 400, 150, 50);
    [button setTitle:@"选择图片的出目录"];
    [button setTarget:self];
    [button setAction:@selector(action2:)];
    [self.view addSubview:button];

    
    
    
    shuchuLujing = [[NSTextField alloc] init];
    shuchuLujing.frame = CGRectMake(200, 400, 250, 30);
    [shuchuLujing setBezeled:NO];
    shuchuLujing.stringValue = @"图片输出文件夹路径";
    [shuchuLujing setDrawsBackground:NO];
    [shuchuLujing setEditable:NO];
    [shuchuLujing setSelectable:NO];
    [self.view addSubview:shuchuLujing];
    
    
    
    
    
    
    
    
    
    
    
    
    tupianGeDaxiao = [[NSTextField alloc] init];
    tupianGeDaxiao.frame = CGRectMake(20, 200, 500, 30);
    [tupianGeDaxiao setBezeled:NO];
    tupianGeDaxiao.textColor = [NSColor redColor];
    tupianGeDaxiao.stringValue = @"图片将处理成 750✖️1130 ";
    [tupianGeDaxiao setDrawsBackground:NO];
    [tupianGeDaxiao setEditable:NO];
    [tupianGeDaxiao setSelectable:NO];
//    [self.view addSubview:tupianGeDaxiao];
    
    
    
    
    button = [[NSButton alloc] init];
    button.frame = CGRectMake(20, 100, 150, 50);
    [button setTitle:@"开始处理"];
    button.tag = 1;
    [button setTarget:self];
    [button setAction:@selector(action4:)];
    [self.view addSubview:button];
    
}



-(void)listFileInPath:(NSString *)path{
    NSFileManager *file = [NSFileManager defaultManager];
    NSArray *arr1  =  [file contentsOfDirectoryAtPath:path error:NULL];
    
    
    
    
    for (NSString *fName in arr1) {
        
        BOOL isDir = NO;
        NSString *luString = [path stringByAppendingPathComponent:fName];
        
       
        [file fileExistsAtPath:luString isDirectory:&isDir];
        
        NSString *newPath = [shuchuString stringByAppendingPathComponent:[luString stringByReplacingOccurrencesOfString:shuruString withString:@""]];
        if (isDir) {
            
            if (![file fileExistsAtPath:newPath]) {
                [file createDirectoryAtPath:newPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
        }
        
        
        
        if (isDir) {
            [self listFileInPath:luString];
        }else{
            

            
            [self chuliWenJian:luString shuruWenjian:fName shuChuLujing:newPath];
            
            
            
 
            
            
            
            
        }
        
    }
    
    
    
    
}



-(void)chuliWenJian:(NSString *)shurujueduiLujing  shuruWenjian:(NSString *)wenjianMing shuChuLujing:(NSString *)shuChuLuJing{
    
    
    NSArray *fileNames = @[@".jpg",@".png",@".jpeg",@".JGP",@".PNG",@".JPEG"];
    BOOL isImage = NO;
    for (NSString *s in fileNames) {
        if ([wenjianMing hasSuffix:s]) {
            isImage = YES;
            break;
        }
    }
    
    if (!isImage) {
        return;
    }
    
    
    
    
 
    
    
    
    NSData *d = [NSData dataWithContentsOfFile:shurujueduiLujing];
    
    NSImage *img = [[NSImage alloc] initWithData:d];
    
    
    CGFloat length1000 = 1000.0,lenth750=750.0,leng562=562.0;
    
    CGFloat imgw = img.size.width;
    CGFloat imgh = img.size.height;
    
    CGFloat f = imgw*1.0/imgh;
    
    
  
    
    CGRect rect = CGRectZero;
    
    CGSize size = CGSizeZero;
    if (f<=0.75) {
        /// 长图  干掉上下
        /// 裁剪后 宽  imgw   高  imgw * length1000/lenth750
        
        
        rect = CGRectMake(0, (imgh-imgw * length1000/lenth750)/2, imgw, imgw * length1000/lenth750);
        
        size = CGSizeMake(lenth750, length1000);
        
        
        
        
    }else if (f>0.75&&f<=0.875){
        
        /// 长图
        
        
        rect = CGRectMake((imgw - imgh*lenth750/length1000)/2, 0, imgh*lenth750/length1000, imgh);
        
        size = CGSizeMake(lenth750, length1000);

        
        
    }else if (f>0.875&&f<=1.15){
        
        
        
        if (f>=1) {
            rect = CGRectMake((imgw - imgh)/2, 0, imgh, imgh);
        }else{
            rect = CGRectMake(0, (imgh-imgw)/2, imgw, imgw );
        }
        
    
        
        size = CGSizeMake(lenth750, lenth750);
        
    }else if (f>1.15&&f<=1.33452){
         /// 宽图
        
        rect = CGRectMake(0, (imgh-imgw * leng562/lenth750)/2, imgw, imgw * leng562/lenth750);
        
        size = CGSizeMake(lenth750, leng562);

        
        
        
    }else if (f>1.33452){
         /// 宽图
       
        
        
        /// 长图
        
        
        rect = CGRectMake((imgw - imgh*lenth750/leng562)/2, 0, imgh*lenth750/leng562, imgh);
        
        size = CGSizeMake(lenth750, leng562);

        
        
    }
    
    
    
    [self tupianChuliZhuYao:size rect2:rect immmm:img xinLujing:shuChuLuJing];
    
    
    
    
    
    
}



-(void)tupianChuliZhuYao:(NSSize)rect1Mubiao rect2:(NSRect )rect2Caijian  immmm:( NSImage *)img xinLujing:(NSString *)xingLujing{
    
    if (rect1Mubiao.height == 0) {
        return;
    }
    
    if (rect2Caijian.size.width == 0) {
        return;
    }
    
    NSBitmapImageRep *rep = [[NSBitmapImageRep alloc]
                             initWithBitmapDataPlanes:NULL
                             pixelsWide:rect1Mubiao.width
                             pixelsHigh:rect1Mubiao.height
                             bitsPerSample:8
                             samplesPerPixel:4
                             hasAlpha:YES
                             isPlanar:NO
                             colorSpaceName:NSCalibratedRGBColorSpace
                             bytesPerRow:0
                             bitsPerPixel:0];
    rep.size = rect1Mubiao;
    
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:rep]];
    
    
    
    
    
    [img drawInRect:NSMakeRect(0, 0, rect1Mubiao.width, rect1Mubiao.height) fromRect:rect2Caijian operation:NSCompositingOperationCopy fraction:1.0];
    
    [NSGraphicsContext restoreGraphicsState];
    
    NSImage *newImage = [[NSImage alloc] initWithSize:rect1Mubiao];
    [newImage addRepresentation:rep];
    
    
    NSImage *immmm = newImage;
    
    NSData *imageData = [immmm TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSDictionary *imageProps = nil;
    NSNumber *quality = [NSNumber numberWithFloat:.85];
    imageProps = [NSDictionary dictionaryWithObject:quality forKey:NSImageCompressionFactor];
    NSData *ddddd = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
    
    
    [ddddd writeToFile:xingLujing atomically:YES];
}







-(void)action4:(id)sender{
    
    if (shuruString.length == 0) {
        NSAlert *alert = [[NSAlert alloc] init];
        
        [alert addButtonWithTitle:@"确定"];
        
    
        
     
        
        [alert setMessageText:@"请选择输入路径"];
        
       
        
        [alert setAlertStyle:NSAlertStyleInformational];
        
        [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger result) {
            
        }];
  
        
        return;
    }
    
    if (shuchuString.length == 0) {
        
        NSAlert *alert = [[NSAlert alloc] init];
        
        [alert addButtonWithTitle:@"确定"];
        
        
        
        
        
        [alert setMessageText:@"请选择出路径"];
        
        
        
        [alert setAlertStyle:NSAlertStyleInformational];
        
        [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger result) {
            
        }];
        
        
        return;
      
    }
    
    
    if ([shuruString isEqualToString:shuchuString]) {
        NSAlert *alert = [[NSAlert alloc] init];
        
        [alert addButtonWithTitle:@"确定"];
        
        
        
        
        
        [alert setMessageText:@"输入输出不能在同一目录"];
        
        
        
        [alert setAlertStyle:NSAlertStyleInformational];
        
        [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger result) {
            
        }];
        
        return;
    }
    
    
//    NSFileManager *file = [NSFileManager defaultManager];
//    NSArray *arr  =  [file contentsOfDirectoryAtPath:shuruString error:NULL];
    
    
    
    [self listFileInPath:shuruString];
    
    
    
    /*
    return;
    
    
    for (NSString *fileName  in arr) {
        
        
        BOOL isDir = NO;
        
        NSString *luString = [NSString stringWithFormat:@"%@%@",shuruString,fileName];
        
 
        
        [file fileExistsAtPath:luString isDirectory:&isDir];
        
        if (isDir) {
            
            NSString *shuchuPath = [NSString stringWithFormat:@"%@%@",shuchuString,fileName];
 
//            [file createFileAtPath:shuchuPath contents:nil attributes:nil];
            [file createDirectoryAtPath:shuchuPath withIntermediateDirectories:YES attributes:nil error:nil];
            
           
            
            
            
            for (NSString *fn in [file contentsOfDirectoryAtPath:luString error:NULL]) {
                
                
                if ([[fn uppercaseString] hasSuffix:@"PNG"] || [[fn uppercaseString] hasSuffix:@"JPG"] ||[[fn uppercaseString] hasSuffix:@"JPEG"]) {
                    
                    NSString *tupianLujing = [NSString stringWithFormat:@"%@%@/%@",shuruString,fileName,fn];
                    
                    NSLog(@"%@",tupianLujing);
                    
                    
 
                    
                    [self chuliTupian:tupianLujing tupianming:fn lujingss:fileName];
                }
                
            }
            
           
            
            
            
            
            
            
            
        }
        
        
      
    }
*/
    
    
    
}


-(void)chuliTupian:(NSString *)wanzhenglujing tupianming:(NSString *)tupianming lujingss:(NSString *)lujingsss{
    
    NSData *d = [NSData dataWithContentsOfFile:wanzhenglujing];
    
    NSImage *img = [[NSImage alloc] initWithData:d];
    
    
    //size1 = CGSizeMake(750, 1000);
    //size2 = CGSizeMake(750, 750);
    // size3 = CGSizeMake(750, 562.5);
    
    CGFloat imgw = img.size.width;
    CGFloat imgh = img.size.height;
    
    CGFloat f = imgw*1.0/imgh;
    
    if (f > 1.1) {
       // chuliLeixing = 3;
        
        
        
        
        NSSize size = NSMakeSize(size3.width, size3.height);
        
        
        
        NSBitmapImageRep *rep = [[NSBitmapImageRep alloc]
                                 initWithBitmapDataPlanes:NULL
                                 pixelsWide:size.width
                                 pixelsHigh:size.height
                                 bitsPerSample:8
                                 samplesPerPixel:4
                                 hasAlpha:YES
                                 isPlanar:NO
                                 colorSpaceName:NSCalibratedRGBColorSpace
                                 bytesPerRow:0
                                 bitsPerPixel:0];
        rep.size = size;
        
        [NSGraphicsContext saveGraphicsState];
        [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:rep]];
        
        
      
        
        
        [img drawInRect:NSMakeRect(0, 0, size.width, size.height) fromRect:NSMakeRect((imgw - imgh * (1.0*size3.width/size3.height))/2.0, 0, imgh * (1.0*size3.width/size3.height), imgh) operation:NSCompositingOperationCopy fraction:1.0];
        
        [NSGraphicsContext restoreGraphicsState];
        
        NSImage *newImage = [[NSImage alloc] initWithSize:size];
        [newImage addRepresentation:rep];
        
        
        NSImage *immmm = newImage;
        
        NSData *imageData = [immmm TIFFRepresentation];
        NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
        NSDictionary *imageProps = nil;
        NSNumber *quality = [NSNumber numberWithFloat:.85];
        imageProps = [NSDictionary dictionaryWithObject:quality forKey:NSImageCompressionFactor];
        NSData *ddddd = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
        
        
        
        [ddddd writeToFile:[NSString stringWithFormat:@"%@%@/%@",shuchuString,lujingsss,tupianming] atomically:YES];
        
        
        
        
    }else if (f  <0.9 ){
//         chuliLeixing = 1;
        
        
        
        NSSize size = NSMakeSize(size1.width, size1.height);
        
        
        
        NSBitmapImageRep *rep = [[NSBitmapImageRep alloc]
                                 initWithBitmapDataPlanes:NULL
                                 pixelsWide:size.width
                                 pixelsHigh:size.height
                                 bitsPerSample:8
                                 samplesPerPixel:4
                                 hasAlpha:YES
                                 isPlanar:NO
                                 colorSpaceName:NSCalibratedRGBColorSpace
                                 bytesPerRow:0
                                 bitsPerPixel:0];
        rep.size = size;
        
        [NSGraphicsContext saveGraphicsState];
        [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:rep]];
        
        
        
        
        
        [img drawInRect:NSMakeRect(0, 0, size.width, size.height) fromRect:NSMakeRect(0, (imgh - imgw*(1.0*size1.height/size1.width))/2.0, imgw,  imgw*(1.0*size1.height/size1.width)) operation:NSCompositingOperationCopy fraction:1.0];
        
        
        
        [NSGraphicsContext restoreGraphicsState];
        
        NSImage *newImage = [[NSImage alloc] initWithSize:size];
        [newImage addRepresentation:rep];
        
        
        NSImage *immmm = newImage;
        
        
        
        
        
        
        NSData *imageData = [immmm TIFFRepresentation];
        NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
        NSDictionary *imageProps = nil;
        NSNumber *quality = [NSNumber numberWithFloat:.85];
        imageProps = [NSDictionary dictionaryWithObject:quality forKey:NSImageCompressionFactor];
        NSData *ddddd = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
        
        
        
         [ddddd writeToFile:[NSString stringWithFormat:@"%@%@/%@",shuchuString,lujingsss,tupianming] atomically:YES];
        
        
        
     
        
        
    }else{
        
        
        NSSize size = NSMakeSize(size2.width, size2.height);
        
        
        
        NSBitmapImageRep *rep = [[NSBitmapImageRep alloc]
                                 initWithBitmapDataPlanes:NULL
                                 pixelsWide:size.width
                                 pixelsHigh:size.height
                                 bitsPerSample:8
                                 samplesPerPixel:4
                                 hasAlpha:YES
                                 isPlanar:NO
                                 colorSpaceName:NSCalibratedRGBColorSpace
                                 bytesPerRow:0
                                 bitsPerPixel:0];
        rep.size = size;
        
        [NSGraphicsContext saveGraphicsState];
        [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:rep]];
        
        
        if (imgw >= imgh) {
            
            
            
            
            
            [img drawInRect:NSMakeRect(0, 0, size.width, size.height) fromRect:NSMakeRect((imgw - imgh)/2.0, 0, imgh, imgh) operation:NSCompositingOperationCopy fraction:1.0];
            
        }else{
            
            
            [img drawInRect:NSMakeRect(0, 0, size.width, size.height) fromRect:NSMakeRect(0, (imgh - imgw)/2.0, imgw,  imgw) operation:NSCompositingOperationCopy fraction:1.0];
        }
        
        
        [NSGraphicsContext restoreGraphicsState];
        
        NSImage *newImage = [[NSImage alloc] initWithSize:size];
        [newImage addRepresentation:rep];
        
        
        NSImage *immmm = newImage;
        
        
        
        
        
        
        NSData *imageData = [immmm TIFFRepresentation];
        NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
        NSDictionary *imageProps = nil;
        NSNumber *quality = [NSNumber numberWithFloat:.85];
        imageProps = [NSDictionary dictionaryWithObject:quality forKey:NSImageCompressionFactor];
        NSData *ddddd = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
        
        
        
         [ddddd writeToFile:[NSString stringWithFormat:@"%@%@/%@",shuchuString,lujingsss,tupianming] atomically:YES];
    }
    
    
    
    
    
    if (chuliLeixing == 1) {
        
        
        
      
        
        
        
    }else if (chuliLeixing == 2) {
        
        
     
        
    
        
        
        
    }else if (chuliLeixing == 3) {
        
        
        
        
       
        
        
    }
    
    
    
    
    
}


-(void)action3:(NSButton *)sender{
    
    chuliLeixing = sender.tag;
    
    if (sender.tag == 1) {
         tupianGeDaxiao.stringValue = @"图片将处理成 750✖️1130 ";
    }else if (sender.tag == 2){
         tupianGeDaxiao.stringValue = @"图片将处理成 750✖️750 ";
    }else if (sender.tag == 3){
         tupianGeDaxiao.stringValue = @"图片将处理成 750✖️546 ";
    }
    
    
}

-(void)action:(id)sender{
    NSLog(@"=================");
    
    NSFileManager *file = [NSFileManager defaultManager];
    NSData *d = [file contentsAtPath:@"/Development/svn/ssss.PNG"];
    
    NSImage *imgc = [[NSImage alloc] initWithData:d];
   
    
}
-(void)action2:(id)sender{
    
    
    
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setMessage:@"请选择目录"];
    [panel setCanChooseDirectories:YES];
    [panel setCanCreateDirectories:YES];
    
    [panel setCanChooseFiles:NO];
    
    [panel beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSInteger result) {
        
        if (result == NSFileHandlingPanelOKButton)
        {
            NSURL* url = [panel URL];
            NSString *str = [url absoluteString];
            
            //            NSLog(@"%@",[str substringFromIndex:7]);
            
            [shuchuString setString:[str substringFromIndex:7]];
            shuchuLujing.stringValue = shuchuString;
            
            
        }
    }];
    
}





-(void)duquPNGgeshu{
    NSFileManager *file = [NSFileManager defaultManager];
    NSArray *arr  =  [file contentsOfDirectoryAtPath:shuruString error:NULL];
    
    int pngCount = 0;
    int jgpCount = 0;
    
    for (NSString *fileName  in arr) {
        if ([[fileName uppercaseString] hasSuffix:@"PNG"]) {
            pngCount ++ ; 
        }
        
        if ([[fileName uppercaseString] hasSuffix:@"JPG"]) {
             jgpCount ++ ;
        }
        
        if ([[fileName uppercaseString] hasSuffix:@"JPEG"]) {
            jgpCount ++ ;
        }
    }
    tupianShulinag.textColor = [NSColor redColor];
    
    
    tupianShulinag.stringValue = [NSString stringWithFormat:@"PNG图片：%d张 ， JGP图片：%d张",pngCount,jgpCount];
}




-(NSString *)decodeString:(NSString*)encodedString

{
    
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}
-(void)action1:(id)sender{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setMessage:@"请选择目录"];
    [panel setCanChooseDirectories:YES];
    [panel setCanCreateDirectories:YES];
    
    [panel setCanChooseFiles:NO];
    
    [panel beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSInteger result) {
        
        if (result == NSFileHandlingPanelOKButton)
        {
            NSURL* url = [panel URL];
            NSString *str = [url absoluteString];
            

            [shuruString setString:[[self decodeString:str] substringFromIndex:7]];
            
            
        }
    }];
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}


@end
