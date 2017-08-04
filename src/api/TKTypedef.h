@class Member;
@class NSError;
@class Account;
@class Blob;
@class Attachment;
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
@class Pricing;
@class Profile;

typedef void (^ _Nonnull OnSuccess)();
typedef void (^ _Nonnull OnError)(NSError * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithBoolean)(BOOL);
typedef void (^ _Nonnull OnSuccessWithString)(NSString * _Nullable);

typedef void (^ _Nonnull OnSuccessWithMember)(Member * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithTKMemberAsync)(TKMemberAsync * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithAccounts)(NSArray<Account *> * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithTKAccountsAsync)(NSArray<TKAccountAsync *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithAccount)(Account * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithTKAccountAsync)(TKAccountAsync * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithToken)(Token * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithTokens)(PagedArray<Token *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithTransfer)(Transfer * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithTransfers)(PagedArray<Transfer *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithBlob)(Blob * _Nullable);

typedef void (^ _Nonnull OnSuccessWithAttachment)(Attachment * _Nullable);

typedef void (^ _Nonnull OnSuccessWithMoney)(Money * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithTransaction)(Transaction * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithTransactions)(PagedArray<Transaction *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithAddress)(AddressRecord * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithAddresses)(NSArray<AddressRecord *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithSubscriber)(Subscriber * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithSubscribers)(NSArray<Subscriber *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithNotification)(Notification * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithNotifications)(PagedArray<Notification *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithTokenOperationResult)(TokenOperationResult * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithBanks)(NSArray<Bank *> * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithBankInfo)(BankInfo * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithDeviceInfo)(DeviceInfo * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithProfile)(Profile * _Nonnull);
