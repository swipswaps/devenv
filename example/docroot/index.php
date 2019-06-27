<!doctype html>
<html lang="eng">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Devenv - PHP Example</title>
        <link href="https://fonts.googleapis.com/css?family=Raleway:100" rel="stylesheet">
        <style media="screen">
            body { color: #636b6f; font-family: Raleway, sans-serif; font-weight: 100; margin: 0 }
            span,a { color: #636b6f;padding: 0 25px; font-size: 14px; font-weight: 600; letter-spacing: .1rem; text-decoration: none; text-transform: uppercase }
        </style>
    </head>
    <body>
        <div style="height: 100vh; align-items: center; display: flex; justify-content: center; position: relative;">
            <div style="text-align: center;">
                <div style="font-size: 84px; margin-bottom: 30px;">
                    Devenv Web Development Environment
                </div>
                <div>
                    <span>PHP Example Application</span>
                </div>
                <div style="margin-top: 25px;">
                    <a href="/info.php">View PHPInfo - <?= phpversion() ?></a>
                </div>
                <div style="margin-top: 25px;">
                    <a href="/database.php">Test Database Connectivity</a>
                </div>
            </div>
        </div>
    </body>
</html>
