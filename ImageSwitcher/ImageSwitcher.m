//
//  ImageSwitcher.m
//  ImageSwitcher
//
//  Created by Isken Huang on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageSwitcher.h"

@implementation ImageSwitcher

@synthesize dataArray;

-(void) newAD:(CGRect)frame dictionary:(NSDictionary *)dictionary index:(int)index{
    UIImageView *myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[dictionary objectForKey:@"image"]]];
    [myImageView setFrame:CGRectMake(index*frame.size.width, 0, frame.size.width, frame.size.height)];
    [myImageView setTag:index];
    [self addSubview:myImageView];
}

/* image switch */
-(void) switchStart{
    myTimer = [NSTimer scheduledTimerWithTimeInterval:(2.0) target:self selector:@selector(switchAD) userInfo:nil repeats:YES];
}

-(void) switchStop{
    [myTimer invalidate];
    myTimer = nil;
}

-(void) switchAD{
    currentAD++;
    
    if (currentAD == self.dataArray.count) {
        currentAD = 0;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.4]; /* animated time */
        for (UIView *view in [self subviews]) {
            [view setFrame:CGRectMake(view.tag*view.frame.size.width, 0, view.frame.size.width, view.frame.size.height)];
        }
        [UIView commitAnimations];
    }else{
        for (UIView *view in [self subviews]) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.4]; /* animated time */
            [view setFrame:CGRectMake(view.frame.origin.x - view.frame.size.width, 0, view.frame.size.width, view.frame.size.height)];
            [UIView commitAnimations];
        }
    }
}

/* touch ad */
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSString *myURL = [[self.dataArray objectAtIndex:currentAD] objectForKey:@"url"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:myURL]];
}

/* init */
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.dataArray = [NSMutableArray new];
        currentAD = 0;
        
        /* add ad */
        NSMutableDictionary *dic1 = [NSMutableDictionary new];
        [dic1 setValue:@"http://www.google.com.tw" forKey:@"url"];
        [dic1 setValue:@"google.png" forKey:@"image"];
        [self.dataArray addObject:dic1];
        
        NSMutableDictionary *dic2 = [NSMutableDictionary new];
        [dic2 setValue:@"https://twitter.com/" forKey:@"url"];
        [dic2 setValue:@"twitter.jpeg" forKey:@"image"];
        [self.dataArray addObject:dic2];
        
        NSMutableDictionary *dic3 = [NSMutableDictionary new];
        [dic3 setValue:@"https://www.facebook.com/" forKey:@"url"];
        [dic3 setValue:@"facebook.jpeg" forKey:@"image"];
        [self.dataArray addObject:dic3];
        
        /* ad to view */
        for (int i=0; i< self.dataArray.count; i++) {
            [self newAD:frame dictionary:[self.dataArray objectAtIndex:i] index:i];
        }

        [self switchStart];
    }
    return self;
}

@end
