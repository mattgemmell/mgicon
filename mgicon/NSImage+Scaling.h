#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface NSImage (MGScaling)

-(NSBitmapImageRep *)unscaledBitmapImageRep;

-(void)saveAsImageType:(NSBitmapImageFileType)imageType
               forSize:(NSSize)targetSize
                atPath:(NSString *)path;

@end