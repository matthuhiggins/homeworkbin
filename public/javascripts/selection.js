HW = {};

HW.selection = (function() {
  function nodeToHtml(node) {
    switch(node.nodeType) {
      case 3:
      case 4: return node.textContent;
      case 1: return '<' + node.nodeName.toLowerCase() + '>' + buildHtml(node.childNodes) + '</' + node.nodeName.toLowerCase() + '>';
      default: return '';
    }
  }

  function nodesToHtml(nodes) {
    var html = '';
    for (var i = 0; nodes[i]; i++) {
      html += nodeToHtml(nodes[i]);
    }
    return html;
  }
  
  return {
    range: function() {
      var selection = window.getSelection();
      return selection.getRangeAt(0);
    },
    dom: function() {
      return this.range().cloneContents();
    },
    html: function() {
      return nodesToHtml(this.dom().childNodes)
    },
    text: function() {
      return this.dom().textContent();
    }
  }
})();