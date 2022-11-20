#!/usr/bin/env bash

set -o errexit

# 获取更新
curl -L https://git.io/GeoLite2-Country.mmdb --output GeoLite2-Country.mmdb
curl -L https://git.io/GeoLite2-ASN.mmdb --output GeoLite2-ASN.mmdb
