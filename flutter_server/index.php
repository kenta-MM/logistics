<?php

use Slim\Factory\AppFactory;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use DI\Container;
use Monolog\Logger;
use Monolog\Handler\StreamHandler;
use Psr\Log\LoggerInterface;

require __DIR__ . '/vendor/autoload.php';
require_once __DIR__ . '/config/database.php';
require_once __DIR__ . '/app/controllers/UserController.php';
require_once __DIR__ . '/app/controllers/RoleController.php';

// コンテナの作成
$container = new Container();

// コンテナーにロガーを設定
$container->set(LoggerInterface::class, function() {
    $logger = new Logger('app');
    $logger->pushHandler(new StreamHandler(__DIR__ . '/logs/app.log', Logger::DEBUG));
    return $logger;
});

// コンテナを使用してSlimアプリケーションを作成
AppFactory::setContainer($container);
$app = AppFactory::create();

$app->addErrorMiddleware(true, true, true);

// CORS対応のミドルウェア
$app->add(function (Request $request, RequestHandler $handler): Response {
    $response = $handler->handle($request);
    
    return $response
        ->withHeader('Content-Type', 'application/json')
        ->withHeader('Access-Control-Allow-Origin', '*')
        ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
        ->withHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
});

// ルート定義: ユーザー全員の取得
$app->get('/users', function (Request $request, Response $response, $args) {
    $controller = new UserController();

    $queryParams = $request->getQueryParams();
    $page       = isset($queryParams['page'])      ? (int)$queryParams['page']        : null;
    $pageSize   = isset($queryParams['pageSize'])  ? (int)$queryParams['pageSize']    : null;

    $users = $controller->getUsers($page, $pageSize);
    $response->getBody()->write(json_encode($users));

    return $response;
});

// ルート定義: 特定のユーザーの取得
$app->get('/users/{id}', function (Request $request, Response $response, $args) {
    $controller = new UserController();
    $user = $controller->getUser($args['id']);
    if ($user) {
        $response->getBody()->write(json_encode($user));
    } else {
        $response = $response->withStatus(404);
        $response->getBody()->write(json_encode(['error' => 'User not found']));
    }
    return $response;
});

// ルート定義: ユーザーの追加または更新
$app->post('/users', function (Request $request, Response $response, $args) {
    // todo:こっちじゃないｔpostデータが取れない。
    $data = json_decode(file_get_contents('php://input'), true);
    // $data = $request->getParsedBody();
    $controller = new UserController();

    if (isset($data['id']) && !empty($data['id'])) {
        // idが存在する場合は更新
        $result = $controller->updateUser($data);
    } else {
        // idが存在しない場合は新規追加
        $result = $controller->addUser($data);
    }
    
    $response->getBody()->write(json_encode($result));
    return $response;
});

// ルート定義: 役割の追加または更新
$app->post('/roles', function (Request $request, Response $response, $args) {
    $data = $request->getParsedBody();
    $controller = new RoleController();
    
    if (isset($data['id']) && !empty($data['id'])) {
        // idが存在する場合は更新
        $result = $controller->updateRole($data);
    } else {
        // idが存在しない場合は新規追加
        $result = $controller->addRole($data);
    }
    $response->getBody()->write(json_encode($result));
    return $response;
});

// ルート定義: 役割の全員取得
$app->get('/roles', function (Request $request, Response $response, $args) {
    $controller = new RoleController();
    $roles = $controller->getAllRoles();
    $response->getBody()->write(json_encode($roles));
    return $response;
});

// オプションリクエストに対する処理 (CORS対応)
$app->options('/{routes:.+}', function (Request $request, Response $response, $args) {
    return $response
        ->withHeader('Access-Control-Allow-Origin', '*')
        ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
        ->withHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization')
        ->withHeader('Access-Control-Allow-Credentials', 'true');
});


// アプリケーション実行
$app->run();
