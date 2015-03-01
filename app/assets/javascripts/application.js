// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require superhero/loader
//= require superhero/bootswatch
//= require turbolinks

var resultsPlaceholder = $('#jumbotronicon')


var fetchTracks = function (albumId, callback) {
$.ajax({
    url: 'https://api.spotify.com/v1/albums/' + albumId,
    success: function (response) {
        callback(response);
    	}
	});

}

var searchAlbums = function (query) {
    $.ajax({
        url: 'https://api.spotify.com/v1/search',
        data: {
            q: query,
            type: 'album'
        },
        success: function (response) {
            resultsPlaceholder.template(response);
        }
    });
};

	


$('#search_query').on('submit', function (e) {
	e.preventDefault;
	searchAlbums($("#search_query").value);	
});
// .addEventListener('submit', function (e) {
//     e.preventDefault();
//     var x = searchAlbums(document.getElementById('search_query').value);
//     console.log(x);
// }); 



