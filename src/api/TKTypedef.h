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
@class BankAuthorization;
@class Subscriber;
@class Notification;
@class PagedArray<Token>;
@class PagedArray<Transaction>;
@class PagedArray<Transfer>;
@class Bank;
@class BankInfo;
@class DeviceInfo;

typedef void (^OnSuccess)();
typedef void (^OnError)( NSError * _Nonnull);

typedef void (^OnSuccessWithBoolean)(BOOL);
typedef void (^OnSuccessWithString)(NSString * _Nonnull);

typedef void (^OnSuccessWithMember)(Member * _Nonnull);
typedef void (^OnSuccessWithTKMemberAsync)(TKMemberAsync * _Nonnull);

typedef void (^OnSuccessWithAccounts)(NSArray<Account *> * _Nonnull);
typedef void (^OnSuccessWithTKAccountsAsync)(NSArray<TKAccountAsync *> * _Nonnull);

typedef void (^OnSuccessWithAccount)(Account * _Nonnull);
typedef void (^OnSuccessWithTKAccountAsync)(TKAccountAsync * _Nonnull);

typedef void (^OnSuccessWithToken)(Token * _Nonnull);
typedef void (^OnSuccessWithTokens)(PagedArray<Token *> * _Nonnull);

typedef void (^OnSuccessWithTransfer)(Transfer * _Nonnull);
typedef void (^OnSuccessWithTransfers)(PagedArray<Transfer *> * _Nonnull);

typedef void (^OnSuccessWithMoney)(Money * _Nonnull);

typedef void (^OnSuccessWithTransaction)(Transaction * _Nonnull);
typedef void (^OnSuccessWithTransactions)(PagedArray<Transaction *> * _Nonnull);

typedef void (^OnSuccessWithAddress)(AddressRecord * _Nonnull);
typedef void (^OnSuccessWithAddresses)(NSArray<AddressRecord *> * _Nonnull);

typedef void (^OnSuccessWithSubscriber)(Subscriber * _Nonnull);
typedef void (^OnSuccessWithSubscribers)(NSArray<Subscriber *> * _Nonnull);

typedef void (^OnSuccessWithNotification)(Notification * _Nonnull);
typedef void (^OnSuccessWithNotifications)(PagedArray<Notification *> * _Nonnull);

typedef void (^OnSuccessWithTokenOperationResult)(TokenOperationResult * _Nonnull);

typedef void (^OnSuccessWithBanks)(NSArray<Bank *> * _Nonnull);
typedef void (^OnSuccessWithBankInfo)(BankInfo * _Nonnull);

typedef void (^OnSuccessWithDeviceInfo)(DeviceInfo * _Nonnull);
