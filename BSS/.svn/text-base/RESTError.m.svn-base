//
//  RESTError.m
//  iHotelApp
//
//  Created by Mugunth Kumar on 1-Jan-11.
//  Copyright 2010 Steinlogic. All rights reserved.
//

#import "RESTError.h"

static NSDictionary *errorCodes;

@implementation RESTError

+ (void) initialize
{
	//NSString *fileName = [NSString stringWithFormat:@"Errors_%@", [[NSLocale currentLocale] localeIdentifier]];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ErrorsList" ofType:@"plist"];
    errorCodes = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
}

+ (void) dealloc
{
	[super dealloc];
}


-(id) init
{
    if ((self = [super init])) {
		
		return self;
	}
    
    return self;
}


//=========================================================== 
//  Keyed Archiving
//
//=========================================================== 
- (void)encodeWithCoder:(NSCoder *)encoder 
{
    [encoder encodeObject:self.errorTitle forKey:@"error"];
    [encoder encodeObject:self.errorCode forKey:@"error_code"];
    [encoder encodeObject:self.errorDescription forKey:@"error_description"];
    [encoder encodeObject:self.errorUri forKey:@"error_uri"];
}

- (id)initWithCoder:(NSCoder *)decoder 
{
    if ((self = [super init])) {
        self.errorTitle = [decoder decodeObjectForKey:@"error"];
        self.errorCode = [decoder decodeObjectForKey:@"error_code"];
        self.errorDescription = [decoder decodeObjectForKey:@"error_description"];
        self.errorUri = [decoder decodeObjectForKey:@"error_uri"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
	[theCopy setErrorCode:self.errorCode];
    [theCopy setErrorTitle:[self.errorTitle copy]];
    [theCopy setErrorDescription:[self.errorDescription copy]];
    [theCopy setErrorUri:self.errorUri];
	
    return theCopy;
}
#pragma mark -
#pragma mark super class implementations

-(int) code
{
	if([self.errorCode intValue] == 0) return [super code];
	else return [self.errorCode intValue];		
}
- (NSString *) domain
{
    // we are assuming that any request within 1000 to 5000 is thrown by our server
	if([self.errorCode intValue] >= 1000 && [self.errorCode intValue] < 5000) return kBusinessErrorDomain;
    else return kRequestErrorDomain;
}

- (NSString*) description
{//[self showCustomErrorWithCode:_errorCode] ]
    return [NSString stringWithFormat:@"%@[%@]:%@", self.errorTitle, self.errorCode,_errorDescription?_errorDescription:[[self.userErrorDic objectForKey:_errorCode] objectForKey:@"description"]];
}

- (NSString*) localizedDescription
{
    if([[self domain] isEqualToString:kBusinessErrorDomain])
        return [[errorCodes objectForKey:self.errorCode] objectForKey:@"title"];
    else
        return [super localizedDescription];
}

- (NSString*) localizedRecoverySuggestion
{
    if([[self domain] isEqualToString:kBusinessErrorDomain])
        return [[errorCodes objectForKey:self.errorCode] objectForKey:@"description"];
    else
        return [super localizedRecoverySuggestion];
}

- (NSString*) localizedOption
{
    if([[self domain] isEqualToString:kBusinessErrorDomain])
        return [[errorCodes objectForKey:self.errorCode] objectForKey:@"Option-1"];
    else
        return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    NSLog(@"Undefined Key: %@", key);
}

#pragma mark -
#pragma mark Our implementations
-(id) initWithDictionary:(NSDictionary*) jsonObject
{
    self = [super init];
    if(self)
    {
        self.errorTitle = [jsonObject objectForKey:@"error"];
        self.errorCode = [NSString stringWithFormat:@"%@",[jsonObject objectForKey:@"error_code"]];
        self.errorDescription = [jsonObject objectForKey:@"error_description"];
        self.errorUri = [jsonObject objectForKey:@"error_uri"];
    }
    return self;
}
-(id) initWithCode:(NSInteger)code description:(NSString*)description{
    self = [super init];
    if(self)
    {
        self.errorCode=[NSString stringWithFormat:@"%d",code];
        self.errorDescription =description;
    }
    return self;
}
-(NSDictionary *) userErrorDic{
    if (!_userErrorDic) {
        _userErrorDic=[[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ErrorsList" ofType:@"plist"]];
    }
    return _userErrorDic;
}

- (void)dealloc{
    self.errorTitle = nil;
    self.errorDescription = nil;
}
@end
