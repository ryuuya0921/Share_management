document.addEventListener('DOMContentLoaded', function () {
  const buttons = document.querySelectorAll('[data-toggle-edit]');

  buttons.forEach(button => {
    // タッチイベントを優先して追加
    button.addEventListener('touchstart', function (event) {
      event.preventDefault(); // タッチイベントのデフォルト動作を無効化
      const commentId = this.getAttribute('data-comment-id');
      toggleEditForm(commentId);
    });

    // フォールバックとしてクリックイベントを追加
    button.addEventListener('click', function () {
      const commentId = this.getAttribute('data-comment-id');
      toggleEditForm(commentId);
    });
  });
});
