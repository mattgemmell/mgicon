#import "NSImage+Scaling.h"

@implementation NSImage (MGScaling)


-(NSBitmapImageRep *)unscaledBitmapImageRep
{
    // From http://stackoverflow.com/a/33780695
    
    NSBitmapImageRep *rep = [[NSBitmapImageRep alloc]
                             initWithBitmapDataPlanes:NULL
                             pixelsWide:self.size.width
                             pixelsHigh:self.size.height
                             bitsPerSample:8
                             samplesPerPixel:4
                             hasAlpha:YES
                             isPlanar:NO
                             colorSpaceName:NSDeviceRGBColorSpace
                             bytesPerRow:0
                             bitsPerPixel:0];
    
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:
     [NSGraphicsContext graphicsContextWithBitmapImageRep:rep]];
    
    [self drawAtPoint:NSMakePoint(0, 0)
             fromRect:NSZeroRect
            operation:NSCompositeSourceOver
             fraction:1.0];
    
    [NSGraphicsContext restoreGraphicsState];
    return rep;
}


-(void)saveAsImageType:(NSBitmapImageFileType)imageType
               forSize:(NSSize)targetSize
                atPath:(NSString *)path
{
    self.size = targetSize;
    
    NSBitmapImageRep * rep = [self unscaledBitmapImageRep];
    
    // Write the target image out to a file
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    NSData *targetData = [rep representationUsingType:imageType properties:imageProps];
    [targetData writeToFile:path atomically: NO];
}


@end