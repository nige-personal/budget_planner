#!/bin/bash
set -e

    if [[ $@ == *"--production"* ]] ;then
    shopt -s nullglob
      files=(log/*)
      if (( ${#files[*]} )); then
        echo 'Removing log files....................'
        rm -r log/*
      fi
      shopt -u nullglob
      echo ''
      echo '***********************************************************************'
      echo '####      Logging in to AWS with pwpr-production credentials      #####'
      echo '***********************************************************************'
      echo ''
      eval "$(aws ecr get-login --profile pwpr-production --region eu-west-1)"
      echo ''
      echo '*****************************************************************************************************************************************************************************************************************'
      echo '          Building the command to run on the container'
      command="RAILS_ENV=production bundle exec rake assets:precompile && RAILS_ENV=production bundle && RAILS_ENV=production bundle exec rake db:migrate && RAILS_ENV=production bundle exec rails s -p 3000 -b '0.0.0.0'"
      echo $command
      echo '*****************************************************************************************************************************************************************************************************************'
      echo ''
      docker build --build-arg APP_DIR=budget --build-arg COMMAND="$command" -t=budget .
      echo ''
      echo ''
      echo '***********************************************************************'
      echo '                Docker image built, all done......'
      echo '***********************************************************************'
      echo ''
    fi

    if [[ $@ == *"--preprod"* ]] ;then
      shopt -s nullglob
      files=(log/*)
      if (( ${#files[*]} )); then
        echo 'Removing log files....................'
        rm -r log/*
      fi
      shopt -u nullglob
      echo ''
      echo '***********************************************************************'
      echo '####      Logging in to AWS with pwpr-preprod credentials         #####'
      echo '***********************************************************************'
      echo ''
      eval "$(aws ecr get-login --profile pwpr-preprod --region eu-west-1)"
      echo ''
      echo '********************************************************************************************************************************************'
      echo '             Building the command to run on the container'
      command="RAILS_ENV=preprod bundle && RAILS_ENV=preprod bundle exec rake db:reset && RAILS_ENV=preprod bundle exec rails s -p 3000 -b '0.0.0.0'"
      echo $command
      echo '********************************************************************************************************************************************'
      echo ''
      docker build --build-arg APP_DIR=budget --build-arg  COMMAND="$command" -t=budget .
      echo ''
      echo ''
      echo '***********************************************************************'
      echo '                Docker image built, all done......'
      echo '***********************************************************************'
      echo ''
    fi