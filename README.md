Overview
========

Token SDK for iOS. Docs https://developer.token.io/sdk/

The SDK is built on top of protobuf gRPC API definition,
https://developer.token.io/sdk/pbdoc/io_token_proto_gateway.html

Client Usage
------------

To use the SDK version compatible with Token's Sandbox testing
environment (typical usage), use the published pod:

```
  pod 'TokenSdk', '~> 1.0.72'
```

The SDK can be added to a client directly from git.

```
  pod 'TokenSdk',  :git => 'https://github.com/tokenio/sdk-objc',:submodules => true
```

or referenced locally in a Podfile

```
  pod 'TokenSdk', :path => '../..'
```

Dependencies
------------

Most of the dependencies are managed with CocoaPods. Some use git submodules. So to initialize everything properly run:

```
git submodule init
git submodule update
pod --repo-update install
```

Pick up new protos
------------------

For now the protos are just copied over from `../lib-proto`. The script fails if the directory is not found. To pick up new protos, run `./bin/update-protos`. After the script finished executing one needs to reload the updated workspace file (with XCode or IntelliJ AppCode).

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



