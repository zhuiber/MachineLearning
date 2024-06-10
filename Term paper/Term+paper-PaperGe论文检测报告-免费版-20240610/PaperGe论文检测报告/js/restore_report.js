var $ = function (tag) {
    return document.querySelectorAll(tag)
}
var pages = 0
function initHeight() {
    $('.report')[0].style.height = window.innerHeight - $('.paper-header')[0].clientHeight + 'px'
    $('.menu_right')[0].style.height = window.innerHeight - $('.paper-header')[0].clientHeight + 'px'
}
function show_dom(evt) {
    if (document.getElementById('dom_none')) {
        //展开
        document.getElementById('dom_none').removeAttribute('id')
        document.getElementById('btnbg').setAttribute('id', 'btn_bg')
    } else {
        //收起
        document.getElementById('btn_bg').setAttribute('id', 'btnbg')
        document.getElementsByClassName('menu_right')[0].setAttribute('id', 'dom_none')
    }
}

var get_time = ''
window.onload = function (e) {
    for (let i = 0; i < total; i++) {
        let div = document.createElement('div');
        div.setAttribute('class', 'pages')
        document.getElementById('content_box').appendChild(div)
        let script = document.createElement('script')
        script.setAttribute('id', 'setHtml')
        script.src = './views/' + i + '.js'
        document.body.appendChild(script)
        document.body.removeChild(script)
    }
    document.getElementById('content_box').addEventListener('scroll', function (event) {
        let index = 0
        for (let i = 0; i < document.getElementsByClassName('pages').length; i++) {
            if (document.getElementsByClassName('pages')[i].offsetTop - 13 <= event.target.scrollTop + event.target.offsetTop) {
                index = i + 1
            }
        }
        if (pages != index) {
            clearTimeout(get_time)
            pages = index
			document.getElementsByClassName('num_input')[0].value = pages
            get_time = setTimeout(function () {
                set_rmHtml()
            }, 200);
        }
    })
    initHeight()
    setIframeHeight($('#menuRight')[0]);
    setHtml()
}
/**
 * 动态添加html
 */
function setHtml() {
    if (total >= 5) {
        for (let i = 0; i < 5; i++) {
            get('./views/' + i + '.html', i)
            pages = i
        }
    } else {
        for (let i = 0; i < total; i++) {
            get('./views/' + i + '.html', i)
            pages = i
        }
    }
}
//上一页
function per_page() {
    if (pages <= 1) {
        return false
    }
    pages -= 1
    set_rmHtml()
    $('.content')[0].scrollTop = $('.pages')[pages - 1].offsetTop
	document.getElementsByClassName('num_input')[0].value = pages
}
//下一页
function nex_page() {
    if (pages >= total) {
        return false
    }
    pages = pages + 1
    set_rmHtml()
    $('.content')[0].scrollTop = $('.pages')[pages - 1].offsetTop
	document.getElementsByClassName('num_input')[0].value = pages
}
function go_page() {
    //console.log(typeof ($('.num_input')[0].value - 0))
    if (typeof ($('.num_input')[0].value - 0) == 'number') {
        let page = $('.num_input')[0].value - 0 - 1
        if (page >= 0 && page <= total) {
            pages = page
            $('.content')[0].scrollTop = $('.pages')[page].offsetTop
        }

    }
}
//设置要显示的元素的内容
function set_rmHtml() {
    //console.log(pages)
    document.getElementById('off_no').innerText = pages
    if (pages < total) {
        for (let i = 0; i < document.getElementsByClassName('pages').length; i++) {
            if (pages > i - 5 && pages < i + 5) {
                get('./views/' + i + '.html', i)
            } else {
                if (document.getElementsByClassName('pages')[i].getElementsByClassName('lb_page')[0]) {
                    document.getElementsByClassName('pages')[i].getElementsByClassName('lb_page')[0].innerHTML = ""
                }
            }
        }
    }
}
function test(params) {
	var menuRight = document.getElementById('menuRight');
	var arr = menuRight.src.split('/');
	var file = arr[arr.length - 1];
	if (file == 'restore_source_default.html' || file != params) {
		menuRight.src = 'source_sections/' + params
	}
}
function get(url, i) {

    let script = document.createElement('script')
    script.setAttribute('id', 'setHtml')
    script.src = './views/' + i + '.js'
    document.body.appendChild(script)
    document.body.removeChild(script)
}
window.onresize = function (e) {
    initHeight()
}

function setIframeHeight(iframe) {
    //console.log(iframe)
    if (iframe) {
        iframe.setAttribute('style', 'height:' + (document.getElementsByClassName('menu_right')[0].clientHeight - 20) + 'px')
    }
}