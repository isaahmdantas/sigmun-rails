directory "app/assets/images", force: true

directory "app/assets/stylesheets", force: true

template "app/javascript/application.js.tt", "app/javascript/application.js", force: true

copy_file "app/javascript/controllers/remote_modal_controller.js", force: true

directory "vendor/javascript", force: true