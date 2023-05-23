directory "app/assets/images", force: true

directory "app/assets/stylesheets", force: true

template "app/javascript/application.js.tt", "app/javascript/application.js", force: true

copy_file "vendor/javascript/custom.js"

copy_file "vendor/javascript/sigmun.js"
