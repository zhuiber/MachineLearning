function acvindex(i, type) {
	if (type == 'source') {
		document.getElementsByClassName('tabindex_suggest')[i].setAttribute('class','tabindex_suggest');
		document.getElementsByClassName('tabindex_source')[i].setAttribute('class','tabindex_source active');
		document.getElementsByClassName('tab_content_source')[i].style.display = 'block';
		document.getElementsByClassName('tab_content_suggest')[i].style.display = 'none';
	} else {
		document.getElementsByClassName('tabindex_suggest')[i].setAttribute('class','tabindex_suggest active');
		document.getElementsByClassName('tabindex_source')[i].setAttribute('class','tabindex_source');
		document.getElementsByClassName('tab_content_source')[i].style.display = 'none';
		document.getElementsByClassName('tab_content_suggest')[i].style.display = 'block';
	}
}
window.onload = function (params) {
    let id = window.location.search.split('?')[1].split('=')[1]
	var div = document.getElementById('RESTORE_' + id);
    if (div) {
        div.style.display = 'block'
		document.getElementsByClassName('tab_content_source')[id].style.display = 'block';
		document.getElementsByClassName('tab_content_suggest')[id].style.display = 'none';
    }
}
let box = document.getElementsByClassName('source-hidden')
var tabContents = document.getElementsByClassName('tab_content_source');
var tabSuggests = document.getElementsByClassName('tab_content_suggest');

setTimeout(function() {
	for (var i = 0; i < box.length; i++) {
		console.log(box[i].clientHeight)
		tabContents[i].style.height = window.innerHeight - document.getElementsByClassName('section_box')[i].clientHeight - 60 + 'px'
		tabContents[i].style.height = window.innerHeight - document.getElementsByClassName('section_box')[i].clientHeight - 60 + 'px'
	}
}, 100);