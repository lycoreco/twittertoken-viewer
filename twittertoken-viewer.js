
/**
 * 指定されたセレクタに一致する要素の value をコピーする
 * @param {string} selector
 */
function CopyToClipboard(selector) {

    // コピー対象のテキストを取得
    const text = document.querySelector(selector).value;

    // テキストをクリップボードにコピーする
    navigator.clipboard.writeText(text);

    // 通知する
    alert('クリップボードにコピーしました。');
}
