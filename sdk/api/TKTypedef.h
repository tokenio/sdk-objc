@class Member;
@class NSError;
@class TKMember;
@class Account;
@class TKAccount;
@class Token;

typedef void (^OnSuccess)();
typedef void (^OnError)(NSError *);

typedef void (^OnSuccessWithMember)(Member *);
typedef void (^OnSuccessWithTKMember)(TKMember *);

typedef void (^OnSuccessWithAccounts)(NSArray<Account *> *);
typedef void (^OnSuccessWithTKAccounts)(NSArray<TKAccount *> *);

typedef void (^OnSuccessWithToken)(Token *);
typedef void (^OnSuccessWithTokens)(NSArray<Token *> *);
