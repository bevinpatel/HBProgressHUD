//
//  BKProgressHUD.m
//
//  Copyright 2015 Bevin Patel.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "BKProgressHUD.h"

#define degreesToRadians(degrees) ((degrees)/(180.0*M_PI))

#if TARGET_INTERFACE_BUILDER
IB_DESIGNABLE
@interface BKProgressHUD (IBDesign)
@property (nonatomic) IBInspectable int32_t redious;
@property (nonatomic) IBInspectable CGFloat progress;
@property (nonatomic) IBInspectable UIColor *tintColor;
@property (nonatomic) IBInspectable UIColor *fillColor;
@property (nonatomic) IBInspectable UIImage *hudImage;
@end
#endif

@interface BKProgressHUD()
{
    CGRect viBounds;
    UIImageView *imageView;
    NSLayoutConstraint *widthConstarint;
    NSLayoutConstraint *heightConstarint;
}
@end

@implementation BKProgressHUD
-(void)layoutSubviews
{
    if (!imageView)
    {
        imageView = [[UIImageView alloc] init];
        [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [imageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:imageView];
        [self setClipsToBounds:YES];
        [self setupConstraints];
    }
}
- (void)drawRect:(CGRect)rect
{
    UIImage *gradiantImage  = [self drawSolid:CGSizeMake(600, 600)];
    UIImage *logoImage     = _hudImage?[BKProgressHUD imageWithImage:_hudImage scaledToWidth:600]:[self drawApple:CGSizeMake(600, 600)];
    [imageView setImage:[self maskImage:gradiantImage withMask:logoImage]];
}
+(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}
-(void)setRedious:(int32_t)redious
{
    _redious = redious;
    widthConstarint.constant = self.redious*2;
    heightConstarint.constant = self.redious*2;
}
-(void)setTintColor:(UIColor *)tintColor
{
    _tintColor = tintColor;
}
-(void)setFillColor:(UIColor *)fillColor
{
    _fillColor=fillColor;
}
-(void)hudImage:(UIImage *)hudImage
{
    _hudImage=hudImage;
}
- (void)setupConstraints
{
    widthConstarint = [NSLayoutConstraint constraintWithItem:imageView
                                                   attribute:NSLayoutAttributeWidth
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:nil
                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:0.5
                                                    constant:self.redious*2];
    [imageView addConstraint:widthConstarint];
    heightConstarint = [NSLayoutConstraint constraintWithItem:imageView
                                                    attribute:NSLayoutAttributeHeight
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:nil
                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                   multiplier:0.5
                                                     constant:self.redious*2];
    [imageView addConstraint:heightConstarint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0.0]];
}
// -----------------------
-(CGRect)getProgressRect:(CGSize)AppleSize{
    
    CGRect progressRect = CGRectMake(0, 0, AppleSize.width, 0);
    CGFloat fillHeight = (self.progress * AppleSize.height)/100;
    progressRect.origin.y=AppleSize.height-fillHeight;
    progressRect.size.height=fillHeight;
    return progressRect;
}
-(UIImage *)drawSolid:(CGSize)gradinatSize{
    
    UIGraphicsBeginImageContextWithOptions(gradinatSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetFillColorWithColor(context, [self.tintColor CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, gradinatSize.width, gradinatSize.height));
    
    CGContextSetFillColorWithColor(context, [self.fillColor CGColor]);
    CGContextFillRect(context, [self getProgressRect:gradinatSize]);

    CGContextRestoreGState(context);
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultingImage;
}
-(UIImage *)drawGradiant:(CGSize)gradinatSize{
    
    CGRect gradiantRect = CGRectMake(0, 0, gradinatSize.width, gradinatSize.width);
    CGFloat colors [] = {
        0.27, 0.52, 0.28, 1.0,
        0.41, 0.62, 0.42, 1.0,
        1.00, 1.00, 0.00, 1.0,
        0.90, 0.35, 0.35, 1.0,
        0.87, 0.20, 0.20, 1.0
    };
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 5);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    UIGraphicsBeginImageContextWithOptions(gradinatSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(gradiantRect), CGRectGetMinY(gradiantRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(gradiantRect), CGRectGetMaxY(gradiantRect));
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient), gradient = NULL;
    
    CGContextRestoreGState(context);
    CGContextDrawPath(context, kCGPathStroke);
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
- (UIImage*) maskImage:(UIImage *) image withMask:(UIImage *) mask{
    
    CGImageRef imageReference = image.CGImage;
    CGImageRef maskReference = mask.CGImage;
    
    CGImageRef imageMask = CGImageMaskCreate(CGImageGetWidth(maskReference),
                                             CGImageGetHeight(maskReference),
                                             CGImageGetBitsPerComponent(maskReference),
                                             CGImageGetBitsPerPixel(maskReference),
                                             CGImageGetBytesPerRow(maskReference),
                                             CGImageGetDataProvider(maskReference),
                                             NULL, // Decode is null
                                             YES // Should interpolate
                                             );
    
    CGImageRef maskedReference = CGImageCreateWithMask(imageReference, imageMask);
    CGImageRelease(imageMask);
    
    UIImage *maskedImage = [UIImage imageWithCGImage:maskedReference];
    CGImageRelease(maskedReference);
    
    return maskedImage;
}
-(UIImage *)drawApple:(CGSize)appleSize{
    
    UIGraphicsBeginImageContextWithOptions(appleSize, NO, 0);
    
    CGContextRef cgContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(cgContext);
    CGContextSetFillColorWithColor(cgContext, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(cgContext, CGRectMake(0, 0, appleSize.width, appleSize.height));
    
    CGContextSetFillColorWithColor(cgContext, [[UIColor blackColor] CGColor]);
    
    CGContextBeginPath(cgContext);
    CGContextMoveToPoint(cgContext, 62, 300);
    CGContextAddCurveToPoint(cgContext,70.000000,190.000000,166.000000,121.000000,305-50,156);//Top Left of Under
    CGContextAddCurveToPoint(cgContext,302.500000,176.000000,301.500000,179.500000,305+50,156);//Top Under
    CGContextAddCurveToPoint(cgContext,425.500000,130.500000,488.000000,152.000000,526,206);//Top Right of under//Try
    CGContextAddCurveToPoint(cgContext,446.500000,249.500000,429.500000,387.000000,541,438);// Cutting Part
    CGContextAddCurveToPoint(cgContext,518.500000,501.500000,493.000000,541.000000,458,576);// Cutting Bottom
    CGContextAddCurveToPoint(cgContext,430.000000,600.500000,401.500000,606.500000,360,585);//Botom Right of Under
    CGContextAddCurveToPoint(cgContext,327.500000,570.000000,297.000000,569.000000,263,585);//Botom Under
    CGContextAddCurveToPoint(cgContext,216.500000,607.000000,193.000000,600.000000,164,575);//Botom Left of Under
    CGContextAddCurveToPoint(cgContext,146.500000,558.000000,119.500000,523.500000,95, 474);
    CGContextAddCurveToPoint(cgContext,70.500000,419.000000,56.000000,363.000000,62, 300);
    CGContextClosePath(cgContext);
    CGContextFillPath(cgContext);
    
    CGContextBeginPath(cgContext);
    CGContextMoveToPoint(cgContext, 300.000000,141.500000);
    CGContextAddCurveToPoint(cgContext,288.500000,79.500000,349.000000,3.500000,419.000000,2.500000);
    CGContextAddCurveToPoint(cgContext,422.500000,60.000000,379.500000,142.000000,300.000000,141.500000);
    CGContextClosePath(cgContext);
    CGContextFillPath(cgContext);
    CGContextRestoreGState(cgContext);
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
@end
