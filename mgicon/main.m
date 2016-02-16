//
//  main.m
//  mgicon
//
//  Created by Matt Gemmell on 16/02/2016.
//  Copyright © 2016 Matt Gemmell. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSImage+Scaling.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *filePath = nil;
        NSString *outputPath = nil;
        NSString *fileExt = nil;
        BOOL useFileExt = YES;
        NSInteger sizeSide = 128;
        BOOL verboseOutput = NO;
        
        /*
         file/path/thing.ext
         
         [-s --size 128]
         
         [-x --extension xls]
         
         -o out/path/thing.ext
         */
        NSArray *args = [[NSProcessInfo processInfo] arguments];
        NSString *helpStr = [NSString stringWithFormat:@"Usage: %@ path/to/file -o image/save/path [-x extension] [-s image-width]\n", [[args objectAtIndex:0] lastPathComponent]];
        
        if (args.count > 1) {
            NSString *argStr = [[args subarrayWithRange:NSMakeRange(1, args.count - 1)] componentsJoinedByString:@" "];
            NSError *error = NULL;
            NSRegularExpression *regex;
            NSTextCheckingResult *match;
            //NSLog(@"Args [%@]", argStr);
            
            // Check for file-extension.
            regex = [NSRegularExpression regularExpressionWithPattern:@"-x\\s*(\\S+)"
                                                              options:0
                                                                error:&error];
            match = [regex firstMatchInString:argStr
                                      options:0
                                        range:NSMakeRange(0, [argStr length])];
            if (match) {
                //NSLog(@"%@ (%@)", match, NSStringFromRange([match rangeAtIndex:1]));
                fileExt = [argStr substringWithRange:[match rangeAtIndex:1]];
                useFileExt = YES;
                //NSLog(@"%@", fileExt);
                argStr = [argStr stringByReplacingOccurrencesOfString:[argStr substringWithRange:[match range]] withString:@""];
                //NSLog(@"Found extension; new args [%@]", argStr);
            } else {
                useFileExt = NO;
            }
            
            // Check for size.
            regex = [NSRegularExpression regularExpressionWithPattern:@"-s\\s*(\\d+)"
                                                              options:0
                                                                error:&error];
            match = [regex firstMatchInString:argStr
                                      options:0
                                        range:NSMakeRange(0, [argStr length])];
            if (match) {
                //NSLog(@"%@ (%@)", match, NSStringFromRange([match rangeAtIndex:1]));
                sizeSide = [[argStr substringWithRange:[match rangeAtIndex:1]] integerValue];
                //NSLog(@"%lu", (long)sizeSide);
                argStr = [argStr stringByReplacingOccurrencesOfString:[argStr substringWithRange:[match range]] withString:@""];
                //NSLog(@"Found size; new args [%@]", argStr);
            }
            
            // Check for verbose flag.
            regex = [NSRegularExpression regularExpressionWithPattern:@"-v\\b"
                                                              options:0
                                                                error:&error];
            match = [regex firstMatchInString:argStr
                                      options:0
                                        range:NSMakeRange(0, [argStr length])];
            if (match) {
                //NSLog(@"%@ (%@)", match, NSStringFromRange([match rangeAtIndex:1]));
                verboseOutput = YES;
                //NSLog(@"%lu", (long)sizeSide);
                argStr = [argStr stringByReplacingOccurrencesOfString:[argStr substringWithRange:[match range]] withString:@""];
                //NSLog(@"Found verbose; new args [%@]", argStr);
            }
            
            // Check for output.
            regex = [NSRegularExpression regularExpressionWithPattern:@"-o\\s*(\\S+)"
                                                              options:0
                                                                error:&error];
            match = [regex firstMatchInString:argStr
                                      options:0
                                        range:NSMakeRange(0, [argStr length])];
            if (match) {
                //NSLog(@"%@ (%@)", match, NSStringFromRange([match rangeAtIndex:1]));
                outputPath = [[argStr substringWithRange:[match rangeAtIndex:1]] stringByStandardizingPath];
                //NSLog(@"%@", outputPath);
                argStr = [argStr stringByReplacingOccurrencesOfString:[argStr substringWithRange:[match range]] withString:@""];
                argStr = [argStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                //NSLog(@"Found output; new args [%@]", argStr);
            } else {
                fprintf(stderr, "-o argument is required.\n");
                fprintf(stderr, "%s\n", [helpStr UTF8String]);
                exit(1);
            }
            
            if (argStr.length > 0) {
                filePath = [argStr stringByStandardizingPath];
            } else if (!useFileExt) {
                fprintf(stderr, "File path argument is required if not specifying a file-extension.\n");
                fprintf(stderr, "%s\n", [helpStr UTF8String]);
                exit(1);
            }
            
        } else {
            fprintf(stderr, "%s\n", [helpStr UTF8String]);
            exit(1);
        }
        
        if (verboseOutput) {
            if (useFileExt) {
                fprintf(stdout, "Extension: %s\n", [fileExt UTF8String]);
            } else {
                fprintf(stdout, "File: %s\n", [filePath UTF8String]);
            }
            fprintf(stdout, "Size: %lu x %lu\n", sizeSide, sizeSide);
            fprintf(stdout, "Output: %s\n", [outputPath UTF8String]);
        }
        
        NSImage *image;
        NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
        BOOL saveFile = (outputPath != nil);
        
        /*
         NSString *appName;
         NSString *type;
         NSString *appPath;
         BOOL success = [workspace getInfoForFile:filePath application:&appName type:&type];
         if (success) {
         appPath = [workspace fullPathForApplication:appName];
         }
         */
        if (useFileExt) {
            image = [workspace iconForFileType:fileExt];
        } else {
            image = [workspace iconForFile:filePath];
        }
        
        NSSize imgSize = NSMakeSize(sizeSide, sizeSide);
        [image setSize:imgSize];
        if (saveFile) {
            [image saveAsImageType:NSPNGFileType forSize:imgSize
                            atPath:outputPath];
        }
    }
    return 0;
}
