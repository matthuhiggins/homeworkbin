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

jQuery.extend({
  submitJSON: function(url, data, callback, type) {
    return jQuery.ajax({
      'url': url,
      'type': type,
      'contentType': 'application/json; charset=utf-8',
      'dataType': 'json',
      'data': JSON.stringify(data),
      beforeSend: function(request) {
        this.headers = {
          'X-Http-Method-Override': type,
          'X-Requested-With': 'XMLHttpRequest'
        }
      },
      'success': function(data) {
        alert(data.foo);
      },
      'error': function() {
      }
    });
  },
  putJSON: function(url, data, callback) {
    return jQuery.submitJSON(url, data, callback, 'put')
  },
  postJSON: function(url, data, callback) {
    return jQuery.submitJSON(url, data, callback, 'post')
  }
});

$(function() {
  $('button, input:submit').button();
});
