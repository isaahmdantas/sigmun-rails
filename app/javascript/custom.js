function initCampoObrigatorio() {
  var originalAddClassMethod = Element.prototype.addClass;
  Element.prototype.addClass = function () {
    var result = originalAddClassMethod.apply(this, arguments);
    if (arguments[0] === 'label-required') {
      if (!this.querySelector('span.required')) {
        var span = document.createElement('span');
        span.setAttribute('aria-required', 'true');
        span.setAttribute('class', 'required');
        span.innerHTML = '&nbsp*';
        this.appendChild(span);
      }
    }
    return result;
  };

  var originalRemoveClassMethod = Element.prototype.removeClass;
  Element.prototype.removeClass = function () {
    var result = originalRemoveClassMethod.apply(this, arguments);
    if (arguments[0] === 'label-required') {
      var requiredSpan = this.querySelector('span.required');
      if (requiredSpan) {
        this.removeChild(requiredSpan);
      }
    }
    return result;
  };

  var labels = document.querySelectorAll('label:not(.label-required)');
  labels.forEach(function (label) {
    var requiredSpan = label.querySelector('span.required');
    if (requiredSpan) {
      label.removeChild(requiredSpan);
    }
  });

  var labelRequired = document.querySelectorAll('.label-required:not(:has(span.required))');
  labelRequired.forEach(function (label) {
    var span = document.createElement('span');
    span.setAttribute('aria-required', 'true');
    span.setAttribute('class', 'required');
    span.innerHTML = '&nbsp*';
    label.appendChild(span);
  });
}
initCampoObrigatorio();