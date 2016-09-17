@class Member;
@class NSError;
@class TKMember;
@class Account;
@class Money;
@class TKAccount;
@class Token;
@class Payment;
@class Transaction;
@class TKMemberAsync;
@class TKAccountAsync;

typedef void (^OnSuccess)();
typedef void (^OnError)(NSError *);

typedef void (^OnSuccessWithMember)(Member *);
typedef void (^OnSuccessWithTKMember)(TKMember *);
typedef void (^OnSuccessWithTKMemberAsync)(TKMemberAsync *);

typedef void (^OnSuccessWithAccounts)(NSArray<Account *> *);
typedef void (^OnSuccessWithTKAccounts)(NSArray<TKAccount *> *);
typedef void (^OnSuccessWithTKAccountsAsync)(NSArray<TKAccountAsync *> *);

typedef void (^OnSuccessWithToken)(Token *);
typedef void (^OnSuccessWithTokens)(NSArray<Token *> *);

typedef void (^OnSuccessWithPayment)(Payment *);
typedef void (^OnSuccessWithPayments)(NSArray<Payment *> *);

typedef void (^OnSuccessWithMoney)(Money *);

typedef void (^OnSuccessWithTransaction)(Transaction *);
typedef void (^OnSuccessWithTransactions)(NSArray<Transaction *> *);
