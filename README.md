Overview
========

Token SDK for iOS. The SDK is built on top of protobuf gRPC API definition.

Pick up new protos
------------------

For now the protos are just copied over from `../lib-proto`. The script fails if the directory is not found. To pick up new protos run `./bin/update-protos`. After the script finished executing one needs to reload the updated workspace file (with XCode or IntelliJ AppCode).

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
