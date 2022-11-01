#!/bin/zsh

curl https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Shadowrocket/Advertising/Advertising.list --output Advertising.list
curl https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Shadowrocket/Advertising/Advertising_Domain.list --output Advertising_Domain.list
curl https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Shadowrocket/China/China.list --output China.list
curl https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Shadowrocket/China/China_Domain.list --output China_Domain.list


# 移除有问题的规则
sed -i '' '/\.similarweb\.com/d' ./Advertising_Domain.list
sed -i '' '/\.statcounter\.com/d' ./Advertising_Domain.list

# 禁用规则
rg --passthru 'URL-REGEX' -r '# URL-REGEX' Advertising.list > temp && mv temp Advertising.list