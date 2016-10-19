@class Member;
@class NSError;
@class Account;
@class Money;
@class TKAccount;
@class Token;
@class Transaction;
@class Transfer;
@class TKMemberAsync;
@class TKAccountAsync;
@class AddressRecord;
@class Subscriber;

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
typedef void (^OnSuccessWithTokens)(NSArray<Token *> *);

typedef void (^OnSuccessWithTransfer)(Transfer *);
typedef void (^OnSuccessWithTransfers)(NSArray<Transfer *> *);

typedef void (^OnSuccessWithMoney)(Money *);

typedef void (^OnSuccessWithTransaction)(Transaction *);
typedef void (^OnSuccessWithTransactions)(NSArray<Transaction *> *);

typedef void (^OnSuccessWithAddress)(AddressRecord *);
typedef void (^OnSuccessWithAddresses)(NSArray<AddressRecord *> *);

typedef void (^OnSuccessWithSubscriber)(Subscriber *);
typedef void (^OnSuccessWithSubscribers)(NSArray<Subscriber *> *);
