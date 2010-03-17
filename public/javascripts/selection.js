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

  function wrapRangeStart(originalRange) {
    var nextRealNode = function(node) {
      while(node.nextSibling) {
        node = node.nextSibling;
        if (node.nodeName != 'LI' || node.nodeType == 1) {
          return node;
        }
      }
    };
    
    var startRange = document.createRange(),
        startNode = originalRange.startContainer;

    startRange.selectNodeContents(startNode);
    startRange.setStart(startNode, originalRange.startOffset);

    var ancestorWithNext = startNode;
    while (!nextRealNode(ancestorWithNext)) {
      ancestorWithNext = ancestorWithNext.parentNode;
    }
    var nextSibling = nextRealNode(ancestorWithNext);

    originalRange.setStart(nextSibling, 0);

    return startRange;
  }
  
  function wrapRangeEnd(originalRange) {
    var previousRealNode = function(node) {
      while(node.previousSibling) {
        node = node.previousSibling;
        if (node.nodeName != 'LI' || node.nodeType == 1) {
          return node;
        }
      }
    };
    
    var endRange = document.createRange(),
        endNode = originalRange.endContainer;
    
    endRange.selectNodeContents(endNode);
    
    endRange.setEnd(endNode, originalRange.endOffset);
    
    var ancestorWithPrevious = endNode;
    while (!previousRealNode(ancestorWithPrevious)) {
      ancestorWithPrevious = ancestorWithPrevious.parentNode;
    }
    var previousSibling = previousRealNode(ancestorWithPrevious);

    if (previousSibling.nodeType === 1) {
      originalRange.setEnd(previousSibling, previousSibling.childNodes.length);
    } else {
      originalRange.setEnd(previousSibling, previousSibling.textContent.length);
    }

    return endRange;
  }
  
  function wrapRange(originalRange) {
    var normalizedChildNodes = function() {
      var fragment = originalRange.cloneContents();
      fragment.normalize();
      return fragment.childNodes;
    }
    
    var childNodes = normalizedChildNodes();

    var repeats = 0;

    while (childNodes.length > 0) {
      if (childNodes.length > 1 && childNodes[0].nodeType === 1) {
        var newStartRange = wrapRangeStart(originalRange);
        wrapRange(newStartRange);
        childNodes = normalizedChildNodes();
      } else if (childNodes.length > 1 && childNodes[childNodes.length - 1].nodeType === 1) {
        var newEndRange = wrapRangeEnd(originalRange);
        wrapRange(newEndRange);
        childNodes = normalizedChildNodes();
      } else {
        var fragments = originalRange.extractContents();
        wrapFragments(fragments.childNodes);
        fragments.normalize();
        originalRange.insertNode(fragments);
        break;
      }
    }
  }
  
  function fragmentToHtml(fragment) {
    switch(fragment.nodeType) {
      case 3:
      case 4: return '<text>' + fragment.textContent + '</text>';
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
    text: function() {
      return this.range().cloneContents().textContent;
    },
    wrap: function() {
      wrapRange(this.range());
      window.getSelection().removeAllRanges();
    }
  }
})();
