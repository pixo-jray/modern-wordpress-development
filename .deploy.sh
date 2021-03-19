#!/bin/bash

marp deck.md -o index.html
docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli s3 sync --acl public-read --delete --exclude ".*"  ./ s3://modern-wordpress-development/
