//
//  MStudent.h
//  KUYUTEC
//
//  Created by kuyuZJ on 2017/8/2.
//
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface MStudent : NSManagedObject

@property(nonatomic,strong) NSString* userName;
@property(nonatomic,strong) NSNumber* sex;
@property(nonatomic,strong) NSNumber* age;

@end
