const careLink = document.querySelector('a[href="care.html"]');
careLink.addEventListener('click', function(event) {
  event.preventDefault();
  alert('Learn how to take care of trees!');
});
const typesLink = document.querySelector('a[href="types.html"]');
typesLink.addEventListener('click', function(event) {
  event.preventDefault();
  alert('Learn about different types of trees!');
});
