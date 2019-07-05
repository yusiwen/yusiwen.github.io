//custom js goes here
(function(document) {
  var toggle = document.querySelector('.sidebar-toggle');
  var sidebar = document.querySelector('#sidebar');
  var checkbox = document.querySelector('#sidebar-checkbox');

  document.addEventListener('click', function(e) {
    var target = e.target;

    if (target === toggle) {
      checkbox.checked = !checkbox.checked;
      e.preventDefault();
    } else if (checkbox.checked && !sidebar.contains(target)) {
      /* click outside the sidebar when sidebar is open */
      checkbox.checked = false;
    }
  }, false);
})(document);
