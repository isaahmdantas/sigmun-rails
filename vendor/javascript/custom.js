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


// init select2
function templateSelect2(controller, placeholder, ajax, allowClear){
    if (ajax == false) {
        return {
            allowClear: allowClear,
            placeholder: placeholder,
            language: {
                errorLoading: function() {
                    return "Os resultados não puderam ser carregados."
                },
                inputTooLong: function(e) {
                    var n = e.input.length - e.maximum,
                        r = "Apague " + n + " caracter";
                    return 1 != n && (r += "es"), r
                },
                inputTooShort: function(e) {
                    return "Digite " + (e.minimum - e.input.length) + " ou mais caracteres"
                },
                loadingMore: function() {
                    return "Carregando mais resultados…"
                },
                maximumSelected: function(e) {
                    var n = "Você só pode selecionar " + e.maximum + " ite";
                    return 1 == e.maximum ? n += "m" : n += "ns", n
                },
                noResults: function() {
                    return "Nenhum resultado encontrado"
                },
                searching: function() {
                    return "Buscando…"
                },
                removeAllItems: function() {
                    return "Remover todos os itens"
                }
            }
            
        }
    }
    else {
        return {
            //dropdownParent: $('.modal'),
            allowClear:  allowClear,
            placeholder: placeholder,
            ajax: {
                url: '/' + controller +'/search/',
                delay: 1000,
                data: function (params) {
                    return { search: params.term };
                },
                dataType: 'json',
                processResults: function (data, page) {
                    var select2data = $.map(data, function (obj) {
                        obj.id = obj.id;
                        obj.text =  obj.nome || obj.text || obj.descricao || obj.titulo;
                        return obj;
                    });
                    return {
                        results: select2data
                    };
                },
            },
            language: {
                errorLoading: function() {
                    return "Os resultados não puderam ser carregados."
                },
                inputTooLong: function(e) {
                    var n = e.input.length - e.maximum,
                        r = "Apague " + n + " caracter";
                    return 1 != n && (r += "es"), r
                },
                inputTooShort: function(e) {
                    return "Digite " + (e.minimum - e.input.length) + " ou mais caracteres"
                },
                loadingMore: function() {
                    return "Carregando mais resultados…"
                },
                maximumSelected: function(e) {
                    var n = "Você só pode selecionar " + e.maximum + " ite";
                    return 1 == e.maximum ? n += "m" : n += "ns", n
                },
                noResults: function() {
                    return "<a class='btn btn-success btn-sm' id='value' data-remote='true' href='/"+controller+"/new'><i class='la la-plus'></i> Add </a>";
                },
                searching: function() {
                    return "Buscando…"
                },
                removeAllItems: function() {
                    return "Remover todos os itens"
                }
            },
            escapeMarkup: function (markup) { return markup; },
            minimumInputLength: 2,
            templateSelection: function (item) {
                return item.nome || item.text || obj.descricao || obj.titulo;
            }
        }
    }

}

function initSelect2(){
    $(".select2_basico").select2(templateSelect2(null, "Selecione", false, true));
}