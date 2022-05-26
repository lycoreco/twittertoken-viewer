<?php

// ini_set('display_errors', true);

require_once 'vendor/autoload.php';

// TwitterOAuth
use Abraham\TwitterOAuth\TwitterOAuth;

// Smarty
$smarty = new Smarty();

// サイトの URL (自分のサイトの URL を指定)
$site_url = 'https://tools.tsukumijima.net/twittertoken-viewer/';

// セッション名 (Cookie に反映される)
$session_name = 'twittertoken-viewer_session';

// セッションを削除する
function session_remove() {

    // セッションを全て空にする
    $_SESSION = [];

    // セッション Cookie も削除する
    setcookie(session_name(), '', time() - 42000, '/');

    // セッションを破壊する
    session_destroy();
}


// 認証
if (isset($_REQUEST['auth'])) {

    // セッション開始
    session_name($session_name);
    session_start();

    try {

        // リクエストに含まれるトークンを使って Twitter に接続
        $connection = new TwitterOAuth($_REQUEST['consumer_key'], $_REQUEST['consumer_secret']);

        // 認証 URL を取得するためのリクエストトークンを作成
        $request_token = $connection->oauth('oauth/request_token', ['oauth_callback' => $site_url]);

        // 認証 URL の取得
        $auth_url = $connection->url('oauth/authenticate', ['oauth_token' => $request_token['oauth_token']]);

        // Consumer Key・Consumer Secret をセッションに保存
        $_SESSION['consumer_key'] = $_REQUEST['consumer_key'];
        $_SESSION['consumer_secret'] = $_REQUEST['consumer_secret'];

        // リクエストトークンをセッションに保存
        $_SESSION['oauth_token'] = $request_token['oauth_token'];
        $_SESSION['oauth_token_secret'] = $request_token['oauth_token_secret'];

        // 認証ページにリダイレクト
        header('Location: '.$auth_url);
        exit;

    } catch (Exception $exception) {

        // エラーなのでセッションを削除する
        session_remove();

        // エラーメッセージ
        if (preg_match('/Callback URL not approved for this client application.*/', $exception)){

            $error = [
                '<b>エラー：Callback URL がアプリ設定で設定されていない、または一致しないため、アプリ連携ができません。</b><br>',
                'Twitter Developer のアプリ設定にて、Callback URLs の項目に Callback URL ('.$site_url.') を追加し、もう一度アプリ連携し直してください。<br>',
            ];

        } else if (preg_match('/Could not authenticate you.*/', $exception)){

            $error = [
                '<b>エラー：認証に失敗したため、アプリ連携ができません。</b><br>',
                '指定した Consumer Key・Consumer Secret が間違っている可能性があります。<br>',
                'Consumer Key・Consumer Secret が正しいかどうか確認し、もう一度アプリ連携し直してください。<br>',
            ];

        } else {

            $error = [
                '<b>エラー：認証中に不明なエラーが発生したため、アプリ連携ができません。</b><br>',
                '<b>'.$exception.'</b><br>',
                'Consumer Key・Consumer Secret が正しいかどうか確認し、もう一度アプリ連携し直してください。<br>',
            ];
        }

        // エラーを表示
        $smarty->assign('type', 'error');
        $smarty->assign('error', $error);
        $smarty->assign('error_title', '<i class="fas fa-sign-in-alt"></i>アプリケーション認証');

    }


// 結果
} else if (isset($_REQUEST['oauth_verifier']) or isset($_REQUEST['denied'])) {

    // セッション開始
    session_name($session_name);
    session_start();

    if (!isset($_GET['denied'])) { // denied でないなら

        try {

            // セッションに保存しておいたリクエストトークンで Twitter に接続
            $connection = new TwitterOAuth($_SESSION['consumer_key'], $_SESSION['consumer_secret'], $_SESSION['oauth_token'], $_SESSION['oauth_token_secret']);

            // アクセストークンを取得
            $access_token = $connection->oauth('oauth/access_token', ['oauth_verifier' => $_REQUEST['oauth_verifier']]);

            // $access_token['oauth_token'] がアクセストークン
            // $access_token['oauth_token_secret'] がアクセストークンシークレット

            // トークンを表示
            $smarty->assign('type', 'result');
            $smarty->assign('access_token', $access_token);

        } catch (Exception $e) {

            // エラーメッセージ
            $error = [
                '<b>エラー：セッションの期限が切れているため、アプリ連携ができません。</b><br>',
                'もう一度アプリ連携し直してください。<br>',
            ];

            // エラーを表示
            $smarty->assign('type', 'error');
            $smarty->assign('error', $error);
            $smarty->assign('error_title', '<i class="fas fa-key"></i>アクセストークンを確認する');

        }

    } else {

        // エラーメッセージ
        $error = [
            '<b>エラー：Twitter アカウントとのアプリ連携が拒否されたため、アプリ連携ができません。</b><br>',
            'もう一度アプリ連携し直してください。<br>',
        ];

        // エラーを表示
        $smarty->assign('type', 'error');
        $smarty->assign('error', $error);
        $smarty->assign('error_title', '<i class="fas fa-key"></i>アクセストークンを確認する');

    }

    // セッションを削除する
    session_remove();


// 通常のアクセス
} else {

    // 画面表示
    $smarty->assign('type', 'normal');
    $smarty->assign('site_url', $site_url);

}

// テンプレートを表示
$smarty->display('index.tpl');
