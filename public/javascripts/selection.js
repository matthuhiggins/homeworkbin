HW = {};

HW.selection = (function() {
  function wrapFragments(fragments) {
    var wrapFragment = function(fragment) {
      if (fragment.nodeType === 3 && fragment.textContent.replace(/\s+/, '') !== '') {
        console.debug('type = ' + fragment.nodeType + ', name = ' + fragment.nodeName + ', text = *' + fragment.textContent + '*');
        var wrapClone = document.createElement('span'),
            parent = fragment.parentNode;
        parent.replaceChild(wrapClone, fragment);
        wrapClone.appendChild(fragment);
      } else if (fragment.nodeType === 1) {
        wrapFragments(fragment.childNodes);
      }
    }
    
    for (var i = 0; fragments[i]; i++) {
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
      return fragmentsToHtml(this.dom().childNodes)
    },
    text: function() {
      return this.dom().textContent();
    },
    wrap: function() {
      var range = HW.selection.range();
      var fragments = range.extractContents();
      
      var wrap = document.createElement("span");
      wrapFragments(fragments.childNodes, wrap);
      
      console.debug('first frag = ' + fragments.childNodes[0]);
      console.debug('frags = ' + fragmentsToHtml(fragments.childNodes));
      
      range.insertNode(fragments);
    }
  }
})();