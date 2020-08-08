#!/bin/bash

template_dir=`pwd`
rm -rf templates.json

res_json='{ "ext_templates":['
idx=0
cd ext
for v in */; do
    v=${v::${#v}-1}
    rm -f ${v}/files.json
    res=`find $v -maxdepth 10 -type f -not -path '*/\.*' | sed 's/^\.\///g' | sed  -e 's/^/templates\/ext\//' | sort | jq -R -s -c 'split("\n")' | jq '.[:-1]'` 
    echo $res > ${v}/files.json

    if [[ $idx != 0 ]]; then
      res_json=$res_json','
    fi

    res_json=$res_json'{"name":"'${v}'","dir":"templates/ext/'${v}'","image":"img/templates/ext/'${v}'.png"}'
    idx=$[$idx +1]
done

res_json=$res_json'],"hugo_templates":['

cd ../hugo/themes

hugo_dir="/Users/tgur/Desktop/projects/hugoThemes/_script/hugoThemeSite/themeSite/public"
idx=0
for v in */; do
    v=${v::${#v}-1}

    rm -f ${v}/files.json
    res=`find $v -maxdepth 10 -type f -not -path '*/\.*' | sed 's/^\.\///g' | sed  -e 's/^/templates\/hugo\/themes\//' | sort | jq -R -s -c 'split("\n")' | jq '.[:-1]'` 
    echo $res > ${v}/files.json

    if [[ $idx != 0 ]]; then
      res_json=$res_json','
    fi

    res_json=$res_json'{"name":"'${v}'","dir":"templates/hugo/themes/'${v}'","image":"/templates/hugo/themes/'${v}'/tn-featured-'${v}'.png"}'
    idx=$[$idx +1]
done

cd ${template_dir}

res_json=$res_json"]}"

echo $res_json > templates.json

echo "all done"

