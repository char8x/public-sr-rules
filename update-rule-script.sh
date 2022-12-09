#!/usr/bin/env bash

set -o errexit

# 获取更新
curl https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Shadowrocket/Advertising/Advertising.list --output Advertising.list
curl https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Shadowrocket/Advertising/Advertising_Domain.list --output Advertising_Domain.list
curl https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Shadowrocket/ChinaMax/ChinaMax.list --output China.list
curl https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Shadowrocket/China/China_Domain.list --output China_Domain.list

# 移除多余的规则
REMOVE_FROM_ADVERTISING_DOMAIN="remove_from_advertising_domain.list"
# Add IFS= option before read command to prevent leading/trailing whitespace from being trimmed
while IFS= read -r remove_domain_line
do
  if [[ $remove_domain_line =~ ^#.* ]]
  then
    echo "ignore $remove_domain_line"
  else
    sed -i '' "/$remove_domain_line/d" ./Advertising_Domain.list
  fi
done < "$REMOVE_FROM_ADVERTISING_DOMAIN"

REMOVE_FROM_ADVERTISING="remove_from_advertising.list"
# Add IFS= option before read command to prevent leading/trailing whitespace from being trimmed
while IFS= read -r remove_ad_line
do
  if [[ $remove_ad_line =~ ^#.* ]]
  then
    echo "ignore $remove_ad_line"
  else
    sed -i '' "/$remove_ad_line/d" ./Advertising.list
  fi
done < "$REMOVE_FROM_ADVERTISING"

REMOVE_FROM_CHINA_DOMAIN="remove_from_china_domain.list"
# Add IFS= option before read command to prevent leading/trailing whitespace from being trimmed
while IFS= read -r remove_china_domain
do
  if [[ $remove_china_domain =~ ^#.* ]]
  then
    echo "ignore $remove_china_domain"
  else
    sed -i '' "/$remove_china_domain/d" ./China_Domain.list
  fi
done < "$REMOVE_FROM_CHINA_DOMAIN"

# 禁用规则
rg --passthru 'URL-REGEX' -r '# URL-REGEX' Advertising.list > temp && mv temp Advertising.list

# 添加缺失规则
ADD_TO_CHINA_DOMAIN="add_to_china_domain.list"
# Add IFS= option before read command to prevent leading/trailing whitespace from being trimmed
while IFS= read -r china_domain_line
do
  if [[ $china_domain_line =~ ^#.* ]]
  then
    echo "ignore $china_domain_line"
  elif [ "$(rg --count-matches --include-zero "$china_domain_line" China_Domain.list)" -eq 0 ]; then
    # 如果不存在这个就加到文件中
    echo "$china_domain_line" >> China_Domain.list # Append to the file
  else
    echo "already has $china_domain_line"
  fi
done < "$ADD_TO_CHINA_DOMAIN"
