apply 'db/template.rb'

copy_file "bin/setup", force: true
chmod "bin/setup", "+x"
