HW = {};

HW.selection = (function() {
  function is_ignorable( nod ) {
    return ( nod.nodeType == 8) || // A comment node
           ( (nod.nodeType == 3) && is_all_ws(nod) ); // a text node, all ws
  }
  
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
  
  function wrapRangeStart(originalRange) {
    var startRange = document.createRange(), 
        startNode = originalRange.startContainer;
  
    startRange.selectNodeContents(startNode);
    startRange.setStart(startNode, originalRange.startOffset);

    if (startNode.nextSibling) {
      originalRange.setStart(startNode.nextSibling, 0);
    } else {
      originalRange.setStart(startNode.parentNode.nextSibling, 0);
    }
    return startRange;
  }
  
  function wrapRangeEnd(originalRange) {
    var endRange = document.createRange(),
        endNode = originalRange.endContainer;
    
    endRange.selectNodeContents(endNode);
    endRange.setEnd(endNode, originalRange.endOffset);
    originalRange.setEndBefore(endNode);
    return endRange;
  }
  
  function wrapRange(originalRange) {
    var clonedContents = originalRange.cloneContents();

    if (clonedContents.childNodes.length > 1 && clonedContents.childNodes[0].nodeType === 1) {
      var newStartRange = wrapRangeStart(originalRange);
      wrapRange(newStartRange);
      wrapRange(originalRange);
    } else if (clonedContents.childNodes.length > 1 && clonedContents.childNodes[clonedContents.childNodes.length - 1].nodeType === 1) {
      var newEndRange = wrapRangeEnd(originalRange);
      wrapRange(originalRange);
      wrapRange(newEndRange);
    } else {
      var fragments = originalRange.extractContents();
      wrapFragments(fragments.childNodes);
      originalRange.insertNode(fragments);
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
      wrapRange(HW.selection.range());
    }
  }
})();