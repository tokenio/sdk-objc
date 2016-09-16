@class Member;
@class NSError;
@class TKMember;
@class Account;
@class TKAccount;

typedef void (^OnSuccess)();
typedef void (^OnError)(NSError *);

typedef void (^OnSuccessWithMember)(Member *);
typedef void (^OnSuccessWithTKMember)(TKMember *);

typedef void (^OnSuccessWithAccounts)(NSArray<Account *> *);
typedef void (^OnSuccessWithTKAccounts)(NSArray<TKAccount *> *);
