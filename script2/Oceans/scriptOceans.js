const conservationLink = document.querySelector('a[href="conservation.html"]');
conservationLink.addEventListener('click', function(event) {
  event.preventDefault();
  alert('Learn how you can help conserve the oceans!');
});
const marineLink = document.querySelector('a[href="marine-life.html"]');
marineLink.addEventListener('click', function(event) {
  event.preventDefault();
  alert('Learn about marine life!');
});
