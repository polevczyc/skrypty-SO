const birdsLink = document.querySelector('a[href="birds.html"]');
birdsLink.addEventListener('click', function(event) {
  event.preventDefault();
  alert('Welcome to the Birds page!');
});
