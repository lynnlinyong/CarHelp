//
//  PhotoWall.m
//  PhotoDemo
//
//  Created by Harry on 12-12-6.
//  Copyright (c) 2012年 Harry. All rights reserved.
//

#import "HGPhotoWall.h"
#import "HGPhoto.h"

@interface HGPhotoWall() <HGPhotoDelegate>
@property (strong, nonatomic) NSMutableArray *arrayPhotos;
@property (nonatomic) BOOL isEditModel;

@end

#define kFrameHeight 80.

#define IMAGE_POSITIONX 4
#define IMAGE_POSITIONY 10

#define IMAGE_WIDTH  80
#define IMAGE_HEIGTH 80

@implementation HGPhotoWall

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0., 0., 320., 0.)];
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
        self.arrayPhotos = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (void)setPhotos:(NSArray*)photos
{
    [self.arrayPhotos removeAllObjects];
    NSUInteger count = [photos count];
    for (int i=0; i<count; i++) {
        
        int row = count/4 + 1;
        int col = i%4;
        
        CGFloat originx = 4 + (col*IMAGE_WIDTH); 
        CGFloat originy = 10+ (row*IMAGE_HEIGTH);
        
        HGPhoto *photoTemp = [[HGPhoto alloc] initWithOrigin:CGPointMake(originx, originy)];
        photoTemp.delegate = self;
        [photoTemp setPhotoUrl:[photos objectAtIndex:i]];
        [self addSubview:photoTemp];
        [self.arrayPhotos addObject:photoTemp];
    }
    
    int row = count/4;
    int col = count%4;

    CGFloat originx = 4  + (col*IMAGE_WIDTH);
    CGFloat originy = 10 + (row*IMAGE_HEIGTH);
    
    HGPhoto *photoTemp = [[HGPhoto alloc] initWithOrigin:CGPointMake(originx, originy)];
    photoTemp.delegate = self;
    photoTemp.hidden = YES;
    [photoTemp setPhotoType:PhotoTypeAdd];
    [self.arrayPhotos addObject:photoTemp];
    [self addSubview:photoTemp];
    
    CGFloat frameHeight = ((count-1)/4+1) * kFrameHeight+10;
    self.frame = CGRectMake(0., 0., 320., frameHeight);
    if (self.delegate)
    {
        if ([self.delegate respondsToSelector:@selector(photoWallReaload)])
        {
            [self.delegate photoWallReaload];
        }
    }
}

- (void)setEditModel:(BOOL)canEdit
{
    self.isEditModel = canEdit;
    if (self.isEditModel) {
        HGPhoto *viewTemp = [self.arrayPhotos lastObject];
        viewTemp.hidden = NO;
    } else {
        HGPhoto *viewTemp = [self.arrayPhotos lastObject];
        viewTemp.hidden = YES;
    }
    
    NSUInteger count = [self.arrayPhotos count]-1;
    for (int i=0; i<count; i++) {
        HGPhoto *viewTemp = [self.arrayPhotos objectAtIndex:i];
        [viewTemp setEditModel:self.isEditModel];
    }
    [self reloadPhotos:self.isEditModel];
}

- (void)addPhoto:(NSString*)string
{
    int count = self.arrayPhotos.count;
    int row = count/4;
    int col = count%4;
    CGFloat originx = 4  + (col*IMAGE_WIDTH);
    CGFloat originy = 10 + (row*IMAGE_HEIGTH);
    
    HGPhoto *photoTemp = [[HGPhoto alloc] initWithOrigin:CGPointMake(originx, originy)];
    photoTemp.delegate = self;
    [photoTemp setEditModel:YES];
    [photoTemp setPhotoUrl:string];
    
    NSUInteger index = [self.arrayPhotos count] - 1;
    [self.arrayPhotos insertObject:photoTemp atIndex:index];
    [self addSubview:photoTemp];
    [self reloadPhotos:YES];
}

- (void)deletePhotoByIndex:(NSUInteger)index
{
    HGPhoto *photoTemp = [self.arrayPhotos objectAtIndex:index];
    [self.arrayPhotos removeObject:photoTemp];
    [photoTemp removeFromSuperview];
    [self reloadPhotos:YES];
}

#pragma mark - Photo

- (void)photoTaped:(HGPhoto*)photo
{
    NSUInteger type = [photo getPhotoType];
    if (type == PhotoTypeAdd) {
        if ([self.delegate respondsToSelector:@selector(photoWallAddAction)]) {
            [self.delegate photoWallAddAction];
        }
    } else if (type == PhotoTypePhoto) {
        NSUInteger index = [self.arrayPhotos indexOfObject:photo];
        if ([self.delegate respondsToSelector:@selector(photoWallPhotoTaped:)]) {
            [self.delegate photoWallPhotoTaped:index];
        }
    }
}

- (void)photoMoveFinished:(HGPhoto*)photo
{
    CGPoint pointPhoto = CGPointMake(photo.frame.origin.x, photo.frame.origin.y);
    CGFloat space = -1;
    NSUInteger oldIndex = [self.arrayPhotos indexOfObject:photo];
    NSUInteger newIndex = -1;
    
    NSUInteger count = [self.arrayPhotos count] - 1;
    for (int i=0; i<count; i++) {

        int row = count/4 + 1;
        int col = i%4;
        
        CGFloat originx = 4 + (col*IMAGE_WIDTH); 
        CGFloat originy = 10+(row*IMAGE_HEIGTH);
        
        CGPoint pointTemp = CGPointMake(originx, originy);
        CGFloat spaceTemp = [self spaceToPoint:pointPhoto FromPoint:pointTemp];
        if (space < 0) {
            space = spaceTemp;
            newIndex = i;
        } else {
            if (spaceTemp < space) {
                space = spaceTemp;
                newIndex = i;
            }
        }
    }
    
    [self.arrayPhotos removeObject:photo];
    [self.arrayPhotos insertObject:photo atIndex:newIndex];
    
    [self reloadPhotos:NO];
    
    if ([self.delegate respondsToSelector:@selector(photoWallMovePhotoFromIndex:toIndex:)]) {
        [self.delegate photoWallMovePhotoFromIndex:oldIndex toIndex:newIndex];
    }
}

- (void)reloadPhotos:(BOOL)add
{
    NSUInteger count = -1;
    if (add) {
        count = [self.arrayPhotos count];
    } else {
        count = [self.arrayPhotos count] - 1;
    }
    for (int i=0; i<count; i++) {
        int row = i/4;
        int col = i%4;
        
        CGFloat originx = 4 + col*IMAGE_WIDTH;
        CGFloat originy = 10+ row*IMAGE_HEIGTH;
        
        HGPhoto *photoTemp = [self.arrayPhotos objectAtIndex:i];
        [photoTemp moveToPosition:CGPointMake(originx, originy)];
    }

    NSUInteger countPhoto = [self.arrayPhotos count];
    CGFloat frameHeight   = ((countPhoto-1)/4+1) * kFrameHeight+10;
    self.frame = CGRectMake(0., 0., 320., frameHeight);
    if (self.delegate)
    {
        if ([self.delegate respondsToSelector:@selector(photoWallReaload)])
        {
            [self.delegate photoWallReaload];
        }
    }
}

- (CGFloat)spaceToPoint:(CGPoint)point FromPoint:(CGPoint)otherPoint
{
    float x = point.x - otherPoint.x;
    float y = point.y - otherPoint.y;
    return sqrt(x * x + y * y);
}

@end
