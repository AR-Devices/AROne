//
//  SQLCommand.h
//  WellnessConnected
//
//  Created by Chenchen Zheng on 3/28/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface SQLCommand : NSObject
{
  sqlite3 *db;
}

-(NSString *) filePath;
-(void) openDB;
-(void) insertQuary:(NSString*)quary;
@end
