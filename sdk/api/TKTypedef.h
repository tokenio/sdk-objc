@class Member;
@class NSError;
@class TKMember;

typedef void (^OnSuccess)();
typedef void (^OnError)(NSError *);

typedef void (^OnSuccessWithMember)(Member *);
typedef void (^OnSuccessWithTKMember)(TKMember *);
