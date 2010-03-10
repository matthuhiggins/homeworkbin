HW = {};

HW.selection = (function() {
  
  function wrapFragment(fragment) {
    if (fragment.nodeType === 3 && fragment.textContent.replace(/\s+/, '') !== '') {
      var wrapClone = document.createElement('span'),
          parent = fragment.parentNode;
      parent.replaceChild(wrapClone, fragment);
      wrapClone.appendChild(fragment);
    } else if (fragment.nodeType === 1) {
      wrapFragments(fragment.childNodes);
    }
  }
  
  function wrapFragments(fragments) {
    for (var i = 0; i < fragments.length; i++) {
      wrapFragment(fragments[i]);
    }
  }
  
  
  function fragmentToHtml(fragment) {
    switch(fragment.nodeType) {
      case 3:
      case 4: return fragment.textContent;
      case 1: return '<' + fragment.nodeName.toLowerCase() + '>' +
                    fragmentsToHtml(fragment.childNodes) +
                    '</' + fragment.nodeName.toLowerCase() + '>';
      default: return '';
    }
  }

  function fragmentsToHtml(fragments) {
    var html = '';
    for (var i = 0; fragments[i]; i++) {
      html += fragmentToHtml(fragments[i]);
    }
    return html;
  }
  
  return {
    range: function() {
      var selection = window.getSelection(),
          range = selection.getRangeAt(0);

      return selection.getRangeAt(0);
    },
    dom: function() {
      return this.range().cloneContents();
    },
    html: function() {
      return fragmentsToHtml(this.dom().childNodes);
    },
    text: function() {
      return this.dom().textContent();
    },
    wrap: function() {
      var originalRange = HW.selection.range(),
          clonedContents = originalRange.cloneContents();
      
      if (clonedContents.childNodes.length > 1 && clonedContents.childNodes[0].nodeType === 1) {
        var startRange = document.createRange(), 
            startNode = originalRange.startContainer;
      
        startRange.selectNodeContents(startNode);
        while (startRange.compareBoundaryPoints(Range.START_TO_START, originalRange) < 0) {
          startRange.setStart(startNode, startRange.startOffset + 1);
        }
        originalRange.setStart(startNode.parentNode.nextSibling, 0);
      }
      
      if (clonedContents.childNodes.length > 1 && clonedContents.childNodes[clonedContents.childNodes.length - 1].nodeType === 1) {
        var endRange = document.createRange(),
            endNode = originalRange.endContainer;
        
        endRange.selectNodeContents(endNode);
        while (endRange.compareBoundaryPoints(Range.END_TO_END), originalRange > 0) {
          endRange.sendEnd(endNode, endRange.endOffset - 1);
        }
      }

      var fragments = originalRange.extractContents();
      console.debug('before = ' + fragmentsToHtml(fragments.childNodes));
      wrapFragments(fragments.childNodes);
      console.debug('after = ' + fragmentsToHtml(fragments.childNodes));

      originalRange.insertNode(fragments);
    }
  }
})();