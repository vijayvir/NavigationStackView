//
//  LeoCustomNavigationController.m
//  NavigationAnimaion
//
//  Created by OSX on 05/02/16.
//  Copyright © 2016 Vijayvir. All rights reserved.
//

#import "LeoCustomNavigationController.h"
#import "AppDelegate.h"

#define kContentViewHeight  50
#define kContentViewFrame_x 0
#define kContentViewFrame_y 20
#define kContentViewFrameHIDE   CGRectMake(0,kContentViewFrame_y, 10, kContentViewHeight)
#define kContentViewFrameUnHide   CGRectMake(0,kContentViewFrame_y, [UIScreen mainScreen].bounds.size.width, kContentViewHeight);
#define kResizeTo CGSizeMake([UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height - 120)
#define kAtPoint CGPointMake(50, 80)
@interface LeoCustomNavigationController()
{
   
      UIScrollView * stacksScrollView ;
      NSMutableArray *stackarr;
    
    UIView * containerView ;
    
}
@end
@implementation LeoCustomNavigationController

//MARK:- CLC
- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if ((self = [super initWithRootViewController:rootViewController])) {
        // Your modifications go here
        
        
         [self loadInitialFeatures];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self loadInitialFeatures];
    
    
}


//MARK: helper function
-(void)loadInitialFeatures{
   
    
    
    containerView = [ [UIView alloc]initWithFrame:kContentViewFrameHIDE];
    
    
    UIView *fake = [ [UIView alloc]initWithFrame:CGRectMake(0,0, 8, kContentViewHeight)];
    
    fake.backgroundColor = [UIColor redColor];
    
    ;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(longPressContiner:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    
    
    [fake addGestureRecognizer:tapRecognizer];
    
    containerView.backgroundColor = [UIColor clearColor];
  //  containerView.backgroundColor = [UIColor yellowColor];
    
    stacksScrollView =[ [UIScrollView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 20)];
    stacksScrollView.contentSize = stacksScrollView.frame.size;
    stackarr =[[NSMutableArray alloc]init];
    stacksScrollView.contentSize = CGSizeMake(0, 20);
    
    [containerView addSubview:stacksScrollView];
    [containerView addSubview:fake];
    stacksScrollView.hidden =YES;
    
    [self.view addSubview:containerView];
    
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [fake addGestureRecognizer:gestureRecognizer];
    
    UISwipeGestureRecognizer *gestureRecognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler1:)];
    [gestureRecognizer1 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [containerView addGestureRecognizer:gestureRecognizer1];
    
//    UILongPressGestureRecognizer *longPressRecognizer1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//    
//    [containerView addGestureRecognizer:longPressRecognizer1];
    
    
    
    
    self.delegate = self;
}

-(void)addLabelOnView{
    [stackarr removeAllObjects];
    for (UILabel * tempLabel in stacksScrollView.subviews)
    {
        
        [tempLabel removeFromSuperview];
        
    }
    [stackarr addObjectsFromArray:self.viewControllers];
    
    
    
    for (int i=1; i<=stackarr.count; i++)
    {
        UIButton * button =[ [UIButton alloc]initWithFrame:CGRectMake(i* (10+5),3, 10, 10)];
        
        
        
        [button addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        
        UILongPressGestureRecognizer *longPressRecognizer1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        
        [button addGestureRecognizer:longPressRecognizer1];
        button.backgroundColor =
        [UIColor clearColor];
        if (i == stackarr.count) {
            
            
            
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 CGRect tempRect =  button. layer.frame;
                                 
                                 //                                 tempRect.origin.x -= 2;
                                 //                                 tempRect.origin.y -= 2;
                                 tempRect.size.height += 4;
                                 tempRect.size.width += 4;
                                 button. layer.frame = tempRect;
                                 
                             }
                             completion:^(BOOL finished){
                                 
                                 
                                 [UIView animateWithDuration:0.5
                                                       delay:0
                                                     options:UIViewAnimationOptionBeginFromCurrentState
                                                  animations:^{
                                                      
                                                      CGRect tempRect = button. layer.frame;
                                                      //                                                      tempRect.origin.x += 2;
                                                      //                                                      tempRect.origin.y += 2;
                                                      tempRect.size.height -= 4;
                                                      tempRect.size.width -= 4;
                                                      button. layer.frame = tempRect;
                                                      
                                                  }
                                                  completion:nil];
                             }];
            
            
            
            
            
            button.layer.backgroundColor = [UIColor greenColor].CGColor;
        }
        else if (i%5 == 0) {
            button.layer.backgroundColor = [UIColor redColor].CGColor;
        }
        else{
            button.layer.backgroundColor = [UIColor orangeColor].CGColor;
        }
        
        button.layer.masksToBounds = NO;
        button.layer.cornerRadius = 5.0f;
        
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
        animation.duration = .7f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.repeatCount = 2;
        [button.layer addAnimation:animation forKey:@"SpinAnimation"];
        
        
        
        
        
        
        
        
        
        
        
        
        [stacksScrollView addSubview:button];
        
        stacksScrollView.contentSize = CGSizeMake(i* (10+5) +10, 20);
        
        if (([UIScreen mainScreen].bounds.size.width) < stacksScrollView.contentSize.width)
        {
            stacksScrollView.contentOffset = CGPointMake(stacksScrollView.contentSize.width - [UIScreen mainScreen].bounds.size.width, 0);
            
            
        }
        
    }
    
}

+ (UIImage *) imageWithView:(UIView *)tapView visibleView:(UIView *)currrentVisibleView
{
    
    
    
    
    
    
    UIGraphicsBeginImageContextWithOptions(currrentVisibleView.bounds.size, currrentVisibleView.opaque, 0.0);
    [currrentVisibleView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img_currrentVisibleView = UIGraphicsGetImageFromCurrentImageContext();
    
   // +(UIImage *)blurWithCoreImage:(UIImage *)sourceImage frameOFSuberView:(CGRect)frame
    ///img_currrentVisibleView =[LeoCustomNavigationController blurWithCoreImage:img_currrentVisibleView frameOFSuberView:currrentVisibleView.frame];
    
    UIGraphicsEndImageContext();
    
    //visible.bounds.size
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tapView.bounds.size.width, tapView.bounds.size.height), tapView.opaque, 0.0);
      [tapView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img_tapView_Context = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();

    
    NSData *imageData = UIImagePNGRepresentation(img_tapView_Context);
    
    
    
    
    
    UIImage *img_TapViewResized=  [LeoCustomNavigationController imageResize:[UIImage imageWithData:imageData] andResizeTo:kResizeTo]   ;
    
    
    UIImage *maskedImage = [LeoCustomNavigationController  drawImage:img_TapViewResized inImage:img_currrentVisibleView atPoint:kAtPoint];
    
    
    
    return maskedImage;
}

+(UIImage *)blurWithCoreImage:(UIImage *)sourceImage frameOFSuberView:(CGRect)frame
{
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
    
    // Apply Affine-Clamp filter to stretch the image so that it does not
    // look shrunken when gaussian blur is applied
    CGAffineTransform transform = CGAffineTransformIdentity;
    CIFilter *clampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    [clampFilter setValue:inputImage forKey:@"inputImage"];
    [clampFilter setValue:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
    
    // Apply gaussian blur filter with radius of 30
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:clampFilter.outputImage forKey: @"inputImage"];
    [gaussianBlurFilter setValue:@30 forKey:@"inputRadius"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:gaussianBlurFilter.outputImage fromRect:[inputImage extent]];
    
    // Set up output context.
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    
    // Invert image coordinates
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -frame.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, frame, cgImage);
    
    // Apply white tint
    CGContextSaveGState(outputContext);
    CGContextSetFillColorWithColor(outputContext, [UIColor colorWithWhite:1 alpha:0.2].CGColor);
    CGContextFillRect(outputContext, frame);
    CGContextRestoreGState(outputContext);
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}


+(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
  
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+(UIImage*) drawImage:(UIImage*) fgImage
              inImage:(UIImage*) bgImage
              atPoint:(CGPoint)  point
{
    UIGraphicsBeginImageContextWithOptions(bgImage.size, FALSE, 0.0);
    
    
    [bgImage drawInRect:CGRectMake( 0, 0, bgImage.size.width, bgImage.size.height) blendMode:kCGBlendModeNormal alpha:1];
    [fgImage drawInRect:CGRectMake( point.x, point.y, fgImage.size.width, fgImage.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


//MARK: - Navigation Delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
  
                                
    
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animate
{
  
    [self addLabelOnView];
   
}






//MARK: Actoins
-(void)tapOnButton:(UIButton*)sender
{
    NSLog(@"%ld",(long)sender.tag);
    
    NSArray *array =[NSArray new];
    array = self.viewControllers;
    
    
    if(array.count !=sender.tag)
    {
        [self popToViewController:[array objectAtIndex:sender.tag-1] animated:YES];
        
        [self addLabelOnView];
    }
   
    
}
//MARK: Gestures
-(void)swipeHandler1:(UISwipeGestureRecognizer *)recognizer {
    
    stacksScrollView.hidden =YES;
    containerView.frame = kContentViewFrameHIDE;
    
}

-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    if (    stacksScrollView.hidden ==YES) {
        stacksScrollView.hidden =NO;
        containerView.frame = kContentViewFrameUnHide
    }
    else{
        stacksScrollView.hidden =YES;
        containerView.frame =  kContentViewFrameHIDE;
    }
}

- (void)longPressContiner:(UITapGestureRecognizer *)gestureRecognizer{
    
    if (    stacksScrollView.hidden ==YES) {
        stacksScrollView.hidden =NO;
        containerView.frame = kContentViewFrameUnHide
    }
    else{
        stacksScrollView.hidden =YES;
        containerView.frame = kContentViewFrameHIDE;
    }
    
    
    
    
    
}
- (void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    
    
    
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        
        if([gestureRecognizer.view isKindOfClass:[UIButton class]])
        {
            UIButton * CurrentLabel =(UIButton*)gestureRecognizer.view ;
            
            
            if (CurrentLabel.tag != self.viewControllers.count )
            {
                UIViewController *tempVc = [self.viewControllers objectAtIndex:CurrentLabel.tag-1];
                UIView * colorEffectViewTo = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tempVc.view.frame.size.width, tempVc.view.frame.size.height)];
                
                colorEffectViewTo.backgroundColor =[UIColor colorWithPatternImage:[LeoCustomNavigationController imageWithView:tempVc.view visibleView:self.topViewController.view]];
                CALayer *myLayer = colorEffectViewTo.layer;
                [myLayer setName:@"PFtagss"];
                
                [self.view.layer addSublayer:myLayer];
            }
        
        }
        
        
        
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        for (CALayer *layer in [self.view.layer sublayers]) {
            
            if ([[layer name] isEqualToString:@"PFtagss"]) {
                [layer removeFromSuperlayer];
            }
        }
    }
    else
    {
        for (CALayer *layer in [self.view.layer sublayers]) {
            
            if ([[layer name] isEqualToString:@"PFtagss"]) {
                [layer removeFromSuperlayer];
            }
        }
    }
}
@end
