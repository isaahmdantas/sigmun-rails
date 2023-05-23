copy_file "lib/templates/rails/scaffold_controller/controller.rb"
copy_file "lib/templates/active_record/model/model.rb"
copy_file "lib/rails/generators/erb/scaffold/scaffold_generator.rb"

directory "lib/generators", force: true
directory "lib/templates/erb", force: true
