#!/bin/bash
php composer.phar require slim/slim
php composer.phar require slim/psr7
php composer.phar require nyholm/psr7 nyholm/psr7-server
php composer.phar require guzzlehttp/psr7 http-interop/http-factory-guzzle
php composer.phar require laminas/laminas-diactoros
mkdir public && touch public/index.php && cd public
read -r -d '' VAR << EOF
<?php
use Psr\\Http\\Message\\ResponseInterface as Response;
use Psr\\Http\\Message\\ServerRequestInterface as Request;
use Slim\\Factory\\AppFactory;

require __DIR__ . '/../vendor/autoload.php';

\$app = AppFactory::create();

\$app->get('/', function (Request \$request, Response \$response, \$args) {
    \$response->getBody()->write("Hello world!");
    return \$response;
});

\$app->run();
EOF

echo "$VAR" > index.php


echo "Do you wish to Start Slim?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )  php -S localhost:8888; break;;
        No ) exit;;
    esac
done

