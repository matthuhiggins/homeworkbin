HW = {};

HW.selection = (function() {
  function nodeToHtml(node) {
    switch(node.nodeType) {
      case 3:
      case 4: return node.textContent;
      case 1: return '<' + node.nodeName.toLowerCase() + '>' + nodesToHtml(node.childNodes) + '</' + node.nodeName.toLowerCase() + '>';
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
      var selection = window.getSelection(),
          range = selection.getRangeAt(0);
          
      // for (var k in selection) if (selection.hasOwnProperty(k)) {
      //   console.debug("selection has " + k)
      // }
      
      // console.debug(range.createContextualFragment());
      // for (var k in range)
        // console.debug("range has " + k)
      
      console.debug('commonAncestorContainer' + ' = ' + range['commonAncestorContainer'].className);
      console.debug('startContainer' + ' = ' + range['startContainer']);
      console.debug('startOffset' + ' = ' + range['startOffset']);
      console.debug('startContainer' + ' = ' + range['startContainer']);
      console.debug('endContainer' + ' = ' + range['endContainer']);
      console.debug('endOffset' + ' = ' + range['endOffset']);

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