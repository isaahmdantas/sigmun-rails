directory "app/assets/images", force: true

File.rename "app/views/stylesheets/application.css", "app/views/stylesheets/application.scss"

directory "app/assets/stylesheets", force: true

copy_file "app/javascript/application.js"

copy_file "vendor/javascript/sigmun.js"
