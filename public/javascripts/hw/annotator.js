HW.Annotator = function(annotations) {
  function nextIdentifier() {
    var max = 0;
    for (var i = 0; i < annotations.length; i++) {
      max = max > annotations[i].identifier ? max : annotations[i].identifier;
    }
    return max + 1;
  }

  return {
    build: function(comment, snippet) {
      return {
        'identifier': nextIdentifier(),
        'comment': comment,
        'snippet': snippet
      };
    },
    create: function(comment, snippet) {
      var annotation = this.build(comment, snippet);
      annotations.push(annotation)
      return annotation;
    },
    destroy: function(identifier) {
      for(var i = 0; i < annotations.length; i++) {
        if (annotations[i].identifier == identifier) {
          annotations.splice(i, 1);
        }
      }
    },
    all: function() {
      return annotations;
    }
  };
};