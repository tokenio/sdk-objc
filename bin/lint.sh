#!/bin/sh
rm -rf /tmp/log
pod lib lint --verbose --no-clean 2>&1 | tee /tmp/log
