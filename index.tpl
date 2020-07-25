<!DOCTYPE html>
<html lang="ja">
<head>

  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Twitter API のアクセストークンを確認するやつ</title>

  <!-- OGP -->
  <meta property="og:type" content="article">
  <meta property="description" content="自分の Twitter API のアクセストークンを確認できます。Bot 作成などに使ってください。">
  <meta property="og:description" content="自分の Twitter API のアクセストークンを確認できます。Bot 作成などに使ってください。">
  <meta property="og:title" content="Twitter API のアクセストークンを確認するやつ">
  <meta property="og:image" content="https://tools.tsukumijima.net/logo.png">
  <meta property="og:locale" content="ja_JP">
  <!-- /OGP -->

  <!-- Twitter Card -->
  <meta name="twitter:card" content="summary">
  <meta name="twitter:description" content="自分の Twitter API のアクセストークンを確認できます。Bot 作成などに使ってください。">
  <meta name="twitter:title" content="Twitter API のアクセストークンを確認するやつ">
  <meta name="twitter:image" content="https://tools.tsukumijima.net/logo.png">
  <!-- /Twitter Card -->

  <!-- JavaScript -->
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" crossorigin="anonymous"></script>

  <!-- CSS -->
  <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="https://use.fontawesome.com/releases/v5.13.1/css/all.css">
  <link rel="stylesheet" type="text/css" href="style.css">

  <script>

    function copyToClipboard(id) {

      // コピー対象を取得
      var copyTarget = document.getElementById(id);

      // コピー対象のテキストを選択する
      copyTarget.select();

      // 選択しているテキストをクリップボードにコピーする
      document.execCommand('Copy');

      alert('クリップボードにコピーしました。');
    }

  </script>

</head>
<body>

  <nav id="navigation" class="navbar navbar-expand-md navbar-dark bg-info">
    <a class="navbar-brand text-white" href="./">
      <i class="fab fa-twitter"></i>Twitter API のアクセストークンを確認するやつ
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbar" aria-expanded="false">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div id="navbar" class="collapse navbar-collapse">
      <div class="container">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item">
            <!--<a class="nav-link text-light" href="/" target="_blank"><i class="fas fa-home"></i></a>-->
          </li>
        </ul>
      </div>
    </div>
  </nav>

{if $type == 'normal'}

  <div class="container mt-4">
    <div class="card">
      <div class="card-header font-weight-bold"><i class="fas fa-info-circle"></i>About</div>
      <div class="card-body">
        <p>
          自分の Twitter アカウントの Twitter API 用アクセストークン・アクセストークンシークレットを確認できます（ほぼ自分用）。<br>
          主な利用例として Bot を想定していますが、他の用途でも開発者アカウント以外のアカウントでツイートしたい場合は使えるはずです。<br>
        </p>
        <p>
          最近、Twitter のスパム対策の一環で、Twitter API の開発者アカウントの取得がなかなか通らなくなっています。<br>
          このため、「Bot にしたいアカウントごとに開発者アカウントを取得する」ことが難しくなってきています。<br>
        </p>
        <p class="mb-2">
          プログラムから Twitter にツイートを投稿する（Twitter API にアクセスする）には、
          <ul>
            <li>コンシューマーキー (Consumer Key)</li>
            <li>コンシューマーシークレット (Consumer Secret)</li>
            <li>アクセストークン (Access Token)</li>
            <li>アクセストークンシークレット (Access Token Secret)</li>
          </ul>
          の4つが必要です。<br>
        </p>
        <p>
          <u>Twitter API アプリは一つの開発者アカウントで複数作成することができる</u>ため、新しい Twitter API アプリを作って Consumer Key と Consumer Secret を取得し、
          あとは Bot にしたいアカウントの Access Token と Access Token Secret が入手できれば、<u>Bot にするアカウントごとにいちいち開発者アカウントを作る必要がなくなります。</u><br>
          ただし、通常の方法では開発者アカウント以外の Twitter アカウントの Access Token と Access Token Secret は Twitter API アプリの設定画面からは入手できず、
          Sign With Twitter 機能をつかってアプリ連携するプログラムを組んだ上で Bot にしたいアカウントを認証（アプリ連携）させ、認証後に手に入れた Access Token 等を使うなどの方法をとることになります。<br>
        <p class="mb-2">
          このサイトは、前述のアプリ連携する機能を実装し、Bot にしたいアカウントとアプリ連携した後に入手した Access Token をそのまま表示するものです。<br>
          <b>入手した Access Token 等は画面に表示する処理のみに利用し、<u>保存は一切行いません。</u></b><br>
          <b>表示された Access Token・Access Token Secret と、別途各自で取得した後、このサイトに入力した開発者アカウント（どのアカウントのでも可）の
          Consumer Key・Consumer Secret を <a href="https://github.com/abraham/twitteroauth" target="_blank">TwitterOAuth</a> などのライブラリに組み込むことで、初めて Twitter API を使ってツイートできるようになります。</b><br>
        </p>
      </div>
    </div>
  </div>

  <div class="container mt-4">
      <div class="card">
        <div class="card-header font-weight-bold"><i class="fas fa-question-circle"></i>つかいかた</div>
        <div class="card-body">
          <ol class="mb-0">
            <li>自分の Twitter API アプリの Consumer Key・Consumer Secret を入力する</li>
            <li>自分の Twitter API アプリ設定画面の Callback URLs 欄に {$callback_url} を登録する</li>
            <ul>
              <li>これを行わないと認証に失敗します…</li>
              <li>Sign With Twitter も有効にしておいてください</li>
              <li><u>アクセストークンを確認するための一時的な登録で構いません</u>（確認後は削除して OK です）</li>
            </ul>
            <li>下の［認証してアクセストークンを確認する］ボタンを押す</li>
            <li>自分の Twitter API アプリとの連携画面が表示されるので、［認証する］ボタンを押す</li>
            <ul>
              <li>あらかじめ Bot にしたいアカウントにログインしている状態で認証してください</li>
            </ul>
            <li>自分の Twitter API アプリで認証したアカウントにアクセスするための Access Token と Access Token Secret が表示されるので、コピーして Bot 内のプログラムに貼り付ける</li>
            <ul>
              <li><b>Access Token と Access Token Secret は絶対に他人に教えないようにしてください！</b></li>
              <li>Access Token と Access Token Secret が漏洩した場合、<u>他人がアカウントを操作可能になってしまう可能性があります。</u></li>
            </ul>
          </ol>
        </div>
      </div>
    </div>

  <div class="container mt-4 mb-4">
    <div class="card">
      <div class="card-header font-weight-bold"><i class="fas fa-key"></i>アクセストークンを確認する</div>
      <form class="card-body" method="POST" action="./?auth" autocomplete="off">
        <p>
          <span style="display: block;" class="mb-2">コンシューマーキー：</span>
          <input name="consumer_key" type="text" class="form-control text-dark mb-2" placeholder="Consumer Key" required />
        </p> 
        <p>
          <span style="display: block;" class="mb-2">コンシューマーシークレット：</span>
          <input name="consumer_secret" type="text" class="form-control text-dark mb-2" placeholder="Consumer Secret" required />
        </p>
        <button type="submit" class="btn btn-primary text-white">
          <i class="fas fa-key"></i>認証してアクセストークンを確認する
        </button>
      </form>
    </div>
  </div>

{/if}
{if $type == 'result'}

  <div class="container mt-4 mb-4">
    <div class="card">
      <div class="card-header font-weight-bold"><i class="fas fa-key"></i>アクセストークンを確認する</div>
      <div class="card-body">
        <p>
          <span style="display: block;" class="mb-2">アクセストークン：</span>
          <input id="access-token" type="text" class="form-control text-dark mb-2" value="{$access_token['oauth_token']}" readonly />
          <button type="button" class="btn btn-info text-white" onclick="copyToClipboard('access-token')">
            <i class="fas fa-paste"></i>クリップボードにコピーする
          </button>
        </p>
        <p>
          <span style="display: block;" class="mb-2">アクセストークンシークレット：</span>
          <input id="access-token-secret" type="text" class="form-control text-dark mb-2" value="{$access_token['oauth_token_secret']}" readonly />
          <button type="button" class="btn btn-info text-white" onclick="copyToClipboard('access-token-secret')">
            <i class="fas fa-paste"></i>クリップボードにコピーする
          </button>
        </p>
        <p class="mb-1">
          <button type="button" class="btn btn-primary text-white" onclick="location.href='./'">
          <i class="fas fa-reply"></i>トップに戻る
          </button>
        </p>
      </div>
    </div>
  </div>

{/if}
{if $type == 'error'}

  <div class="container mt-4 mb-4">
    <div class="card">
      <div class="card-header font-weight-bold">{$error_title}</div>
      <div class="card-body">
        <div class="alert alert-danger" role="alert">
          {foreach from=$error item="error_item"}
            {$error_item}
          {/foreach}
        </div>
        <p class="mb-1">
          <button type="button" class="btn btn-primary text-white" onclick="location.href='./'">
          <i class="fas fa-reply"></i>トップに戻る
          </button>
        </p>
      </div>
    </div>
  </div>

{/if}

  <nav id="footer" class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <div class="navbar-header" style="display: flex; align-items: center;">
        <a class="navbar-brand text-white small" style="font-size: 95%;" href="./">
          © 2019 - {date('Y')}
        </a>
        <img id="counter" src="/dream/dream.cgi?id=twittertoken_viewer&gif=1">
      </div>
    </div>
  </nav>

</body>
</html>
