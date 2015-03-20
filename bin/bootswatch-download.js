var fs = require('fs'),
    http = require('http'),
    BOOTSWATCH_API_URL = 'http://api.bootswatch.com/3/',
    verbose = false;

function getThemeList (on_complete) {
	var response_data = '';

	var request = http.get(BOOTSWATCH_API_URL, function (res) {
		if (verbose)
			console.log('API_STATUS: ' + res.statusCode);

		res.on('data', function (chunk) {
			response_data += chunk;
		});

		res.on('end', function () {
			on_complete(response_data);
		});
	});
}

var path = '';

if (process.argv.length !== 3 || process.argv[2] === '-h' || process.argv[2] === '--help') {
	console.log('Usage: node bootswatch-download.js path_to_directory\n  Where path_to_directory is a directory to place Bootswatch CSS files.');
	process.exit(0);
} else {
	path = process.argv[2];
}

getThemeList(function (response) {
	var themes = JSON.parse(response).themes;

	themes.forEach(function (theme) {
		var fname = theme.name.toLowerCase() + '.min.css';
		var fstream = fs.createWriteStream(path + '/' + fname);

		if (verbose)
			console.log(fname);

		http.get(theme.cssMin, function (res) {
			res.pipe(fstream);
		});
	});
});