#!/usr/bin/env bash

buildBaseImage() {
  echo "Building base image"
  docker buildx build \
    --progress=plain \
    --label prisma \
    --tag prisma-arm32v7:node-14 \
    --target base \
    base
}

buildAppImage() {
  # App builds on top of base image
#  buildBaseImage
 
  echo "Building app image"
  docker buildx build \
    --progress=plain \
    --label prisma,app \
    --tag prisma:app \
    app
}

menu() {
  OPTIONS=(base app)
  select OPTION in ${OPTIONS[@]}; do
    if [ $OPTION = "base" ]; then
      buildBaseImage
      break;
    elif [ $OPTION = "app"  ]; then
      buildAppImage
      break;
    else
      echo "Incorrect Input: Select a number 1-${#OPTIONS[@]}"
    fi
  done
}

menu
exit


