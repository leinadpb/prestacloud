#!/bin/bash

set -x

bundle exec rake -t
bundle exec rails db:migrate
bundle exec rails db:seed