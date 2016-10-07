@class Member;
@class NSError;
@class Account;
@class Money;
@class TKAccount;
@class Payment;
@class PaymentToken;
@class Transaction;
@class TKMemberAsync;
@class TKAccountAsync;
@class Address;

typedef void (^OnSuccess)();
typedef void (^OnError)(NSError *);

typedef void (^OnSuccessWithMember)(Member *);
typedef void (^OnSuccessWithTKMemberAsync)(TKMemberAsync *);

typedef void (^OnSuccessWithAccounts)(NSArray<Account *> *);
typedef void (^OnSuccessWithTKAccountsAsync)(NSArray<TKAccountAsync *> *);

typedef void (^OnSuccessWithAccount)(Account *);
typedef void (^OnSuccessWithTKAccountAsync)(TKAccountAsync *);

typedef void (^OnSuccessWithPaymentToken)(PaymentToken *);
typedef void (^OnSuccessWithPaymentTokens)(NSArray<PaymentToken *> *);

typedef void (^OnSuccessWithPayment)(Payment *);
typedef void (^OnSuccessWithPayments)(NSArray<Payment *> *);

typedef void (^OnSuccessWithMoney)(Money *);

typedef void (^OnSuccessWithTransaction)(Transaction *);
typedef void (^OnSuccessWithTransactions)(NSArray<Transaction *> *);

typedef void (^OnSuccessWithAddress)(Address *);
typedef void (^OnSuccessWithAddresses)(NSArray<Address *> *);

typedef void (^OnSuccessWithPreferences)(NSString *);
