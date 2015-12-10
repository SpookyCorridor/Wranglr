(function(){
	var v = '2.1.0';
	/*
		adding jQuery if it's not already on the page and
		sticking with a low version for browser compatability. 

		Once it's finished: run the bookmarklet
	*/
	if (window.jQuery === undefined || window.jQuery.fn.jquery < v) {
		var done = false; 
		var script = document.createElement('script'); 
		script.src = 'http://ajax.googleapis.com/ajax/libs/jquery/' + v + '/jquery.min.js';
		script.onload = script.onreadystatechange = function(){
			if (!done && (!this.readyState || this.readyState == 'loaded' || this.readyState == 'complete')) {
				done = true; 
				initMyBookmarklet(); 
			}
		}; 
		document.getElementsByTagName('head')[0].appendChild(script);
	} else {
		initMyBookmarklet(); 
	}

	function initMyBookmarklet() {
		(window.initMyBookmarklet = function() {
			window.open('http://www.google.com', '_blank');
			var stats = {}; // request-body object of words 
			var wordList = []; 
			/*
				Grab only text in body. 
				There are probably ways of stripping away more potentially
				unwanted things by avoiding asides or footers but not 
				guaranteed 
			*/ 

			var content = $('body').text(); 

			/* 
				Regex pattern is used to grab all the words because it's fast
				and very specific in this case. Avoids numbers and special
				characters that would become outliers 
			*/ 

			var re = /([a-zA-Z]+){4,}/ig; 
			wordList = content.match(re); 

			/* 
				sorting prior to building up the request object for AJAX
			*/ 

			wordList.sort();
			for (i = 0; i < wordList.length; i++) {

				/*
					if the word already exists in the object then iterate
					else: add it to the list! 
				*/ 

				stats.hasOwnProperty(wordList[i]) ? stats[wordList[i]] += 1 : stats[wordList[i]] = 1; 			
			
			}

			/*
				For larger sets of text, a header request wouldn't be possible. 
				set processData to false to send over data in request body instead
			*/ 


			$.ajax({
				url: "http://localhost:9292/stats",
				type: "POST",
				processData: false, 
				data: JSON.stringify(stats),
				error: function(jqXHR, textStatus, err) {
					console.log(jqXHR); 
					console.log(textStatus);
					console.log(err);
				},
				success: function(data) {
					/* 
						The server needs store the word cloud information and 
						return a proper URL since popup blockers prevent an automatic 
						redirect with async
					*/ 
					$('body').append('<a class="wranglrCloud" href="'+data+'">link</a>"');  
				}
 			});

			
			
		})(); 
	}
})();