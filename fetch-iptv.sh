#!/usr/bin/env bash

set -o errexit

# 获取更新
curl https://raw.githubusercontent.com/YueChan/IPTV/main/IPTV.m3u --output iptv.m3u
curl https://raw.githubusercontent.com/YueChan/Radio/main/Radio.m3u --output radio.m3u
