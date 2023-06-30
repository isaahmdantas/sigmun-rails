class MenuGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)


  def create_header_file
    header_file_path = "app/views/layouts/partials/_menu.html.erb"
    
    if File.exist?(header_file_path)
      append_menu_to_file(header_file_path)
    end
  end
  
  private

    def append_menu_to_file(file_path)
      menu_content = menu_content_to_append
    
      File.open(file_path, "a") do |file|
        file.puts(menu_content)
      end
    end
  
    def menu_content_to_append
      <<~HTML
        <li>
          <a class="nav-link" href="<%= admin_#{plural_table_name}_path %>">
            <div class="sm-hero__sidenav-link-icon"><svg class="svg-inline--fa fa-table-columns" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="table-columns" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M0 96C0 60.65 28.65 32 64 32H448C483.3 32 512 60.65 512 96V416C512 451.3 483.3 480 448 480H64C28.65 480 0 451.3 0 416V96zM64 416H224V160H64V416zM448 160H288V416H448V160z"></path></svg><!-- <i class="fas fa-columns"></i> Font Awesome fontawesome.com --></div>
            #{singular_table_name.camelize.constantize.model_name.human(count: 2).titleize}
          </a>
        </li>
      HTML
    end


end