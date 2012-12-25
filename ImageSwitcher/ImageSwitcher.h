//
//  ImageSwitcher.h
//  ImageSwitcher
//
//  Created by Isken Huang on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageSwitcher : UIView{
    NSTimer *myTimer;
    int currentAD;
}

@property (nonatomic, retain) NSMutableArray *dataArray;

@end
