@class Member;
@class NSError;
@class Account;
@class Money;
@class TKAccount;
@class Token;
@class TokenOperationResult;
@class Transaction;
@class Transfer;
@class TKMemberAsync;
@class TKAccountAsync;
@class AddressRecord;
@class Subscriber;
@class PagedArray<Token>;
@class PagedArray<Transaction>;
@class PagedArray<Transfer>;

typedef void (^OnSuccess)();
typedef void (^OnError)(NSError *);

typedef void (^OnSuccessWithBoolean)(BOOL);

typedef void (^OnSuccessWithMember)(Member *);
typedef void (^OnSuccessWithTKMemberAsync)(TKMemberAsync *);

typedef void (^OnSuccessWithAccounts)(NSArray<Account *> *);
typedef void (^OnSuccessWithTKAccountsAsync)(NSArray<TKAccountAsync *> *);

typedef void (^OnSuccessWithAccount)(Account *);
typedef void (^OnSuccessWithTKAccountAsync)(TKAccountAsync *);

typedef void (^OnSuccessWithToken)(Token *);
typedef void (^OnSuccessWithTokens)(PagedArray<Token *> *);

typedef void (^OnSuccessWithTransfer)(Transfer *);
typedef void (^OnSuccessWithTransfers)(PagedArray<Transfer *> *);

typedef void (^OnSuccessWithMoney)(Money *);

typedef void (^OnSuccessWithTransaction)(Transaction *);
typedef void (^OnSuccessWithTransactions)(PagedArray<Transaction *> *);

typedef void (^OnSuccessWithAddress)(AddressRecord *);
typedef void (^OnSuccessWithAddresses)(NSArray<AddressRecord *> *);

typedef void (^OnSuccessWithSubscriber)(Subscriber *);
typedef void (^OnSuccessWithSubscribers)(NSArray<Subscriber *> *);

typedef void (^OnSuccessWithTokenOperationResult)(TokenOperationResult *);
