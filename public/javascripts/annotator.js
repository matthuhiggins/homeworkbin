HW.Annotator = function(annotations) {
  return {
    nextIdentifier: function() {
      var max = 0;
      for (var i = 0; i < annotations.length; i++) {
        max = max > annotations[i].identifier ? max : annotations[i].identifier;
      }
      return max + 1;
    },
  
    create: function(comment, snippet) {
      var annotation = {
        'identifier': this.nextIdentifier(),
        'comment': comment,
        'snippet': snippet
      };
      annotations.push(annotation)
      return annotation;
    },
    remove: function(identifier) {
      
    }
  };
};