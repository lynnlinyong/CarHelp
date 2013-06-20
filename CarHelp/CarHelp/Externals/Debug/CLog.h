//
//  CLog.h
//  Financialplanner
//
//  Created by jsetc on 12-8-31.
//  Copyright 2012年 seed. All rights reserved.
//

#ifdef DEBUG
#define CDLog(fmat, ...) NSLog(fmat, ## __VA_ARGS__)
#else
#define CDLog(fmat, ...)
#endif