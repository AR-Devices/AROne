//
//  SQLCommand.m
//  WellnessConnected
//
//  Created by Chenchen Zheng on 3/28/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "SQLCommand.h"
#import "sqlite3.h"

@implementation SQLCommand
#pragma mark - Sqlite3 Database Commands

  //file path to database
-(NSString *) filePath
{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  return  [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ANDWellness.sql"];
}

  //open the database
-(void)openDB
{
  if (sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK) {
    sqlite3_close(db);
    NSAssert(0, @"Database failed to open");
  } else {
    NSLog(@"database opened");
  }
}

-(void)insertQuary:(NSString*)quary
{
  char *err;
  if (sqlite3_exec(db, [quary UTF8String], NULL, NULL, &err) != SQLITE_OK){
    sqlite3_close(db);
    NSAssert(0, @"Cloud not update table");
  }else {
    NSLog(@"table updated");
  }
}
@end
