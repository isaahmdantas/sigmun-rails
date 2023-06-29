// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import 'select2'

import "sigmun"
import "custom"

$(".select2_basico").select2({
    theme: 'bootstrap-5',
    allowClear: true,
    placeholder: 'Selecione',
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
});