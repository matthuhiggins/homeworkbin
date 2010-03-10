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
    var startRange = document.createRange(), 
        startNode = originalRange.startContainer;
  
    startRange.selectNodeContents(startNode);
    startRange.setStart(startNode, originalRange.startOffset);

    var ancestorWithNext = startNode;
    while (!ancestorWithNext.nextSibling) {
      ancestorWithNext = ancestorWithNext.parentNode;
    }
    console.debug('ancestorWithNext = ' + ancestorWithNext);
    var nextSibling = ancestorWithNext.nextSibling; 

    originalRange.setStart(nextSibling, 0);

    return startRange;
  }
  
  function wrapRangeEnd(originalRange) {
    var endRange = document.createRange(),
        endNode = originalRange.endContainer;
    
    endRange.selectNodeContents(endNode);
    endRange.setEnd(endNode, originalRange.endOffset);
    
    var ancestorWithPrevious = endNode;
    while (!ancestorWithPrevious.previousSibling) {
      ancestorWithPrevious = ancestorWithPrevious.parentNode;
    }
    var previousSibling = ancestorWithPrevious.previousSibling;

    if (previousSibling.nodeType === 1) {
      originalRange.setEnd(previousSibling, previousSibling.childNodes.length);
    } else {
      originalRange.setEnd(previousSibling, previousSibling.textContent.length);
    }

    return endRange;
  }
  
  function wrapRange(originalRange, stackLevel) {
    if (stackLevel > 100) {
      console.debug('stack too deep');
      return;
    } else {
    }

    var clonedContents = originalRange.cloneContents();

    if (clonedContents.childNodes.length > 1 && clonedContents.childNodes[0].nodeType === 1) {
      var newStartRange = wrapRangeStart(originalRange);
      wrapRange(newStartRange, stackLevel + 1);
      wrapRange(originalRange, stackLevel + 1);
    } else if (clonedContents.childNodes.length > 1 && clonedContents.childNodes[clonedContents.childNodes.length - 1].nodeType === 1) {
      var newEndRange = wrapRangeEnd(originalRange);
      wrapRange(originalRange, stackLevel + 1);
      wrapRange(newEndRange, stackLevel + 1);
    } else {
      var fragments = originalRange.extractContents();
      wrapFragments(fragments.childNodes);
      originalRange.insertNode(fragments);
      // originalRange.detach();
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
      wrapRange(HW.selection.range(), 0);
    }
  }
})();