document.addEventListener('DOMContentLoaded', function () {
  const buttons = document.querySelectorAll('[data-toggle-edit]');
  let touchHandled = false;

  buttons.forEach(button => {
    // タッチイベントを優先して追加
    button.addEventListener(
      'touchstart',
      function (event) {
        event.preventDefault();
        touchHandled = true; // タッチイベントが処理されたことを記録
        const commentId = this.getAttribute('data-comment-id');
        toggleEditForm(commentId);
      },
      { passive: false }
    );

    // フォールバックとしてクリックイベントを追加
    button.addEventListener('click', function (event) {
      if (touchHandled) {
        touchHandled = false; // タッチイベントが既に処理されている場合はスキップ
        return;
      }
      const commentId = this.getAttribute('data-comment-id');
      toggleEditForm(commentId);
    });
  });
});
