//
//  CoreDataManager.m
//  KUYUTEC
//
//  Created by kuyuZJ on 2017/8/2.
//
//

#import "CoreDataManager.h"



@implementation CoreDataManager

@synthesize context = _context;
@synthesize model = _model;
@synthesize persistent = _persistent;


static CoreDataManager *coredataManager;
+ (instancetype) shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coredataManager = [[self alloc] init];
    });
    return coredataManager;
}

-(instancetype)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(void)save{
    NSError* error = nil;
    if([self.context hasChanges] && ![self.context save:&error]){
        abort();
    }
}

-(NSManagedObjectContext *)context{
    if(_context == nil){
        _context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_context setPersistentStoreCoordinator:self.persistent];
    }
    return _context;
}

-(NSManagedObjectModel *)model{
    if(_model == nil){
//        NSURL* url = [[NSBundle mainBundle] URLForResource: @"Model" withExtension: @"momd"];
          NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
        _model = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
    }
    return _model;
}

-(NSPersistentStoreCoordinator *)persistent{
    if(_persistent == nil){
             NSString* fileName =  @"Model.sqlite";
        NSURL* url = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:fileName];
   
        NSError* error = nil;
        
        _persistent = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.model];
        
        if(![_persistent addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error]){
            NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
            dict[NSLocalizedDescriptionKey] =  @"Failed to initialize the application's saved data";
            dict[NSLocalizedFailureReasonErrorKey] =  @"There was an error creating or loading the application's saved data.";
            dict[NSUnderlyingErrorKey] = error;
            error = [NSError errorWithDomain: @"you error domain" code:999 userInfo:dict];
            abort();
        }
    }
    return _persistent;
}












@end
