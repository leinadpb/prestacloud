#!/bin/bash

set -x

bundle check || bundle install
bundle exec rails db:migrate
bundle exec rails db:seed