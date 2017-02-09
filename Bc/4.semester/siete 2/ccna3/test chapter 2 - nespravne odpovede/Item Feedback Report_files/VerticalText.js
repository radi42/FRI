var VerticalText = new function() {

  function determine() {
    if (document && document.documentElement) {
      var style = document.documentElement.style;
      for (var i = 0; i < arguments.length; i++) {
        if (style[arguments[i]] !== undefined) {
          return arguments[i];
        }
      }
    }
    return null;
  }

  var transformOrigin = determine(
    'transformOrigin',
    'WebkitTransformOrigin',
    'MozTransformOrigin',
    'msTransformOrigin',
    'OTransformOrigin'
  );

  var transform = determine(
    'transform',
    'WebkitTransform',
    'MozTransform',
    'msTransform',
    'OTransform'
  );

  var capable = (transformOrigin && transform);

  this.apply = function(element) {

    if (!capable) {
      return;
    }

    if (!(element instanceof HTMLElement)) {
      return;
    }

    var content = document.createElement('div');
    content.style.display = 'block';
    content.style.position = 'absolute';
    content.style.whiteSpace = 'nowrap';
    while (element.hasChildNodes()) {
      content.appendChild(element.firstChild);
    }

    var container = document.createElement('div');
    container.style.margin = 'auto';
    container.style.display = 'block';
    container.style.position = 'relative';
    container.appendChild(content);
    element.appendChild(container);

    var width = content.offsetWidth;
    var height = content.offsetHeight;
    var halfHeight = Math.round((height * 100) / 2) / 100; // round to the nearest hundredth
    container.style.width = height + 'px';
    container.style.height = width + 'px';
    content.style.bottom = '0';
    content.style[transformOrigin] = halfHeight + 'px ' + halfHeight + 'px';
    content.style[transform] = 'rotate(-90deg)';

  };

}();
