<?php

try {
    $connection     = true;
    $database = new PDO(
        'mysql:host=devenv-test-mariadb;dbname=test;charset=utf8',
        'test',
        'devenv',
        array(PDO::ATTR_EMULATE_PREPARES => false,
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        )
    );
} catch (PDOException $exception) {
    $error = array(
        'error' => 'Database connection error.',
        'exception' => $exception->getMessage()
    );
    $connection = false;
}

if ($connection === true) {
    ?>
    <!doctype html>
    <html lang="eng">
        <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>DevEnv - PHPenv</title>
            <link href="https://fonts.googleapis.com/css?family=Raleway:100" rel="stylesheet">
            <style media="screen">
                body { color: #636b6f; font-family: Raleway, sans-serif; font-weight: 100; margin: 0 }
                    .subheader,a { color: #636b6f;padding: 0 25px; font-size: 14px; font-weight: 600; letter-spacing: .1rem; text-decoration: none; text-transform: uppercase }
            </style>
        </head>
        <body>
            <div style="height: 100vh; align-items: center; display: flex; justify-content: center; position: relative;">
                <div style="text-align: center;">
                    <div style="font-size: 84px; margin-bottom: 30px;">
                        Database Connection Test <span style="color: green;">Succeeded</span>
                    </div>
                    <div>
                        <span class="subheader">Successfully connected to the MariaDB container.</span>
                    </div>
                </div>
            </div>
        </body>
    </html>

    <?php
} else {
    ?>
    <!doctype html>
    <html lang="eng">
        <head>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>DevEnv - PHPenv</title>
            <link href="https://fonts.googleapis.com/css?family=Raleway:100" rel="stylesheet">
            <style media="screen">
                body { color: #636b6f; font-family: Raleway, sans-serif; font-weight: 100; margin: 0 }
                .subheader,a { color: #636b6f;padding: 0 25px; font-size: 14px; font-weight: 600; letter-spacing: .1rem; text-decoration: none; text-transform: uppercase }
            </style>
        </head>
        <body>
            <div style="height: 100vh; align-items: center; display: flex; justify-content: center; position: relative;">
                <div style="text-align: center;">
                    <div style="font-size: 84px; margin-bottom: 30px;">
                        Database Connection Test <span style="color: red;">FAILED</span>
                    </div>
                    <div>
                        <span class="subheader"><?= $error['exception']; ?></span>
                    </div>
                </div>
            </div>
        </body>
    </html>
    <?php
}
