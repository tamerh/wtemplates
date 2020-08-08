#!/bin/bash


hugo_dir="/Users/tgur/Desktop/projects/hugoThemes/_script/hugoThemeSite/themeSite/public"

cd /hugo/themes

# TODO initiate hugo build script and copy static files here
for v in */; do
 # copy screentshot images
    cp ${hugo_dir}"/"${v}/tn-featured-${v}.png ${template_dir}"/hugo/themes/"${v}"/"
done
