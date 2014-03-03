//
//  ARSummary.m
//  AROne
//
//  Created by Chenchen Zheng on 2/28/14.
//  Copyright (c) 2014 Chenchen Zheng. All rights reserved.
//

#import "ARSummary.h"
#import <Parse/PFObject+Subclass.h>

@implementation ARSummary
@dynamic maxAcceleration;
@dynamic maxSpeed;
@dynamic verticalDrop;
@dynamic date;
@dynamic player;
@dynamic displayName;

+ (NSString *)parseClassName {
  return @"Summary";
}

//- (id)init {
//  self = [super init];
//  
//  return self;
//}

//- (void) setPlayer: (PFUser *) player  {
//  self.player = player;
//  
//  self.ACL = [PFACL ACLWithUser:self.player];
//  
//}


@end
