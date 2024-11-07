function toggleEditForm(commentId) {
  const displayDiv = document.getElementById(`comment-display-${commentId}`);
  const editFormDiv = document.getElementById(`comment-edit-form-${commentId}`);

  // 表示を切り替え
  if (displayDiv.style.display === "none") {
    displayDiv.style.display = "block";
    editFormDiv.style.display = "none";
  } else {
    displayDiv.style.display = "none";
    editFormDiv.style.display = "block";
  }
}

window.toggleEditForm = toggleEditForm;
