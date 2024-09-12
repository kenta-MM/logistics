#!/bin/bash

# 動的に割り当てられるIPアドレスを取得
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# PHPのスタンドアロンサーバーを指定されたIPアドレスとポート8000で起動
php -S $IP_ADDRESS:8000
