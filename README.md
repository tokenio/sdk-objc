Overview
========

Token SDK for iOS. The SDK is built on top of protobuf gRPC API definition.

Pick up new protos
------------------

For now the protos are just copied over from `../lib-proto`. The script fails if the directory is not found. To pick up new protos run `./bin/update-protos`. After the script finished executing one needs to reload the updated workspace file (with XCode or IntelliJ AppCode).

Dependencies
------------

Most of the dependcies are managed with CocoaPods. Some use git submodules. So to initialize everything properly run:

```
git submodule init
git submodule update
pod --repo-update install
```

Run Tests
---------

Local environment:

```
./bin/run-tests
```

Development environment:

```
./bin/run-tests-dev
```

Staging environment:

```
./bin/run-tests-staging
```

Client Usage
------------

The SDK can be added to a client directly from git.

```
  pod 'TokenSdk',  :git => 'https://bitbucket.org/tokenio/sdk-objc',:submodules => true
```

or referenced locally in a Podfile

```
  pod 'TokenSdk', :path => '../..'
```
