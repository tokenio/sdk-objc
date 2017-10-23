Overview
========

Token SDK for iOS. Docs https://developer.token.io/sdk/

The SDK is built on top of protobuf gRPC API definition,
https://developer.token.io/sdk/pbdoc/io_token_proto_gateway.html

Client Usage
------------

The SDK can be added to a client directly from git.
To use the version compatible with Token's
"sandbox" testing environment:

```
  source 'https://github.com/tokenio/token-cocoa-pods.git'
  pod 'TokenSdk'
```

To use a specific version, e.g., 1.0.72:

```
  source 'https://github.com/tokenio/token-cocoa-pods.git'
  pod 'TokenSdk', '1.0.72'
```

or

```
  pod 'TokenSdk', :git => 'https://github.com/tokenio/sdk-objc', :submodules => true, :tag => 'v1.0.72'
```

Or your Podfile can refer to a repo cloned on disk (but you must update the
clone "by hand"):

```
  pod 'TokenSdk', :path => '../sdk-objc'
```

Dependencies
------------

Most of the dependencies are managed with CocoaPods. Some use git submodules. So to initialize everything properly run:

```
git submodule init
git submodule update
pod --repo-update install
```

Run Tests
---------

Development environment:

```
./bin/run-tests-dev
```

Staging environment:

```
./bin/run-tests-staging
```

Local environment (Token-internal):

```
./bin/run-tests
```



