@class Member;
@class NSError;
@class Account;
@class BankAuthorization;
@class Blob;
@class Attachment;
@class Money;
@class TKAccountSync;
@class TKBalance;
@class Token;
@class TokenOperationResult;
@class Transaction;
@class Transfer;
@class TKMember;
@class TKAccount;
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
@class Alias;
@class Key;
@class TokenMember;
@class MemberRecoveryOperation;
@class ExternalAuthorizationDetails;
@class Device;

typedef NS_ENUM(int32_t, NotifyStatus);

typedef void (^ _Nonnull OnSuccess)(void);
typedef void (^ _Nonnull OnAuthRequired)(ExternalAuthorizationDetails * _Nonnull);
typedef void (^ _Nonnull OnError)(NSError * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithBoolean)(BOOL);
typedef void (^ _Nonnull OnSuccessWithString)(NSString * _Nullable);

typedef void (^ _Nonnull OnSuccessWithMember)(Member * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithTKMember)(TKMember * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithKeys)(NSArray<Key *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithAliases)(NSArray<Alias *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithAccounts)(NSArray<Account *> * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithTKAccounts)(NSArray<TKAccount *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithAccount)(Account * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithTKAccount)(TKAccount * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithToken)(Token * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithTokens)(PagedArray<Token *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithTransfer)(Transfer * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithTransfers)(PagedArray<Transfer *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithBlob)(Blob * _Nullable);

typedef void (^ _Nonnull OnSuccessWithAttachment)(Attachment * _Nullable);

typedef void (^ _Nonnull OnSuccessWithMoney)(Money * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithTKBalance)(TKBalance * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithTKBalances)(NSDictionary<NSString *,TKBalance *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithTransaction)(Transaction * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithTransactions)(PagedArray<Transaction *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithAddress)(AddressRecord * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithAddresses)(NSArray<AddressRecord *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithSubscriber)(Subscriber * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithSubscribers)(NSArray<Subscriber *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithNotification)(Notification * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithNotifications)(PagedArray<Notification *> * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithTokenOperationResult)(TokenOperationResult * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithBankAuthorization)(BankAuthorization * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithBanks)(NSArray<Bank *> * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithBankInfo)(BankInfo * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithDeviceInfo)(DeviceInfo * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithProfile)(Profile * _Nonnull);

typedef void (^ _Nonnull OnSuccessWithTokenMember)(TokenMember * _Nullable);

typedef void (^ _Nonnull OnSuccessWithMemberRecoveryOperation)(MemberRecoveryOperation * _Nullable);

typedef void (^ _Nonnull OnSuccessWithPairedDevices)(NSArray<Device *> * _Nonnull);
typedef void (^ _Nonnull OnSuccessWithNotifyStatus)(NotifyStatus);

