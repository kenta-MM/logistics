<?php
// config/database.php

require 'vendor/autoload.php';


// config.ini ファイルを読み込む
$config = parse_ini_file(__DIR__ . '/config.ini', true);


ORM::configure('mysql:host=' . $config['database']['host'] . ';dbname=' . $config['database']['dbname']);
ORM::configure('username', $config['database']['username']);
ORM::configure('password', $config['database']['password']);