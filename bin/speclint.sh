#!/bin/sh
rm -rf /tmp/slog
pod spec lint --verbose --no-clean 2>&1 | tee /tmp/slog
