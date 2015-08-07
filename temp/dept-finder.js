var http = require('http'),
    fs = require('fs'),
    site_list = [],
    dept_file = 'http://webdev.its.msstate.edu/assets/data/departments.json',
    max_length = 14;

function getSiteListing(options, onResult) {
	var req = http.request(options, function(res) {
		var output = [];

		res.setEncoding('utf8');

		res.on('data', function (chunk) {
			output.push(chunk);
		});

		res.on('end', function() {
			site_list = JSON.parse(output);
			onResult(res.statusCode);
		});
	});

	req.end();
}

function findDepartment(dept) {
	dept += '.msstate.edu';
	var ret = '???';

	site_list.forEach(function(d) {
		var match = d.websites.filter(function (item) {
			return dept == item;
		});

		if (match.length !== 0) {
			ret = d.name;
			return;
		}
	});

	return ret;
}

// Check to see if we were supplied with a file of sites to check.
if (process.argv[2] === '-f' || process.argv[2] === '--file') {
	var contents = fs.readFileSync(process.argv[3], {encoding: 'UTF-8'});

	getSiteListing(dept_file, function(statusCode) {
		contents.split('\n').forEach(function(line) {
			var cols = line.split('\t');

			/* cols[] should now have the following (for valid entries):
			 *   0: department name (what we're finding so likely an empty string)
			 *   1: first portion of site address (e.g. educ for educ.msstate.edu)
			 *   2: the date
			 *   3: start time
			 *   4: end time
			 */
			if (cols[0] === '' && cols[1] !== undefined && cols[2] !== undefined) {
				// The department has not been assigned yet, but there is a website on the line...
				console.log(findDepartment(cols[1]).slice(0, max_length) + line);
			} else {
				console.log(line);
			}
		});
	});
} else { // If not supplied a file, we iterate through all the arguments individually.
	getSiteListing(dept_file, function(statusCode) {
		for (var i = 2; i < process.argv.length; i++) {
			var dept_name = findDepartment(process.argv[2]);
			console.log(dept_name.slice(0, max_length));
		}
	});
}
