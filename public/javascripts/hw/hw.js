window.HW = {
  fragmentToHtml: function(fragment) {
    switch(fragment.nodeType) {
      case 3:
      case 4: return '<text>' + fragment.textContent + '</text>';
      case 1: return '<' + fragment.nodeName.toLowerCase() + '>' +
                    this.fragmentsToHtml(fragment.childNodes) +
                    '</' + fragment.nodeName.toLowerCase() + '>';
      default: return '';
    }
  },
  fragmentsToHtml: function(fragments) {
    var html = '';
    for (var i = 0; fragments[i]; i++) {
      html += this.fragmentToHtml(fragments[i]);
    }
    return html;
  }
};

// jQuery.postJSON = function(url, data, callback) {
//  return jQuery.ajax({
//     'url': url,
//     'type': 'put',
//     'contentType': 'application/json; charset=utf-8',
//     'dataType': 'json',
//     'data': JSON.stringify(submitData()),
//     beforeSend: function(request) {
//       this.headers = {'X-Http-Method-Override': 'put'}
//     },
//     'success': function(data) {
//       alert(data.foo);
//     },
//     'error': function() {
//     }
//   });
// };