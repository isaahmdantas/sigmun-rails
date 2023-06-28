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
          <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapse#{human_name}" aria-expanded="false" aria-controls="collapse#{human_name}">
            <div class="sm-hero__sidenav-link-icon"><svg class="svg-inline--fa fa-table-columns" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="table-columns" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M0 96C0 60.65 28.65 32 64 32H448C483.3 32 512 60.65 512 96V416C512 451.3 483.3 480 448 480H64C28.65 480 0 451.3 0 416V96zM64 416H224V160H64V416zM448 160H288V416H448V160z"></path></svg><!-- <i class="fas fa-columns"></i> Font Awesome fontawesome.com --></div>
            #{human_name}
            <div class="sm-hero__sidenav-collapse-arrow"><svg class="svg-inline--fa fa-angle-down" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-down" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" data-fa-i2svg=""><path fill="currentColor" d="M192 384c-8.188 0-16.38-3.125-22.62-9.375l-160-160c-12.5-12.5-12.5-32.75 0-45.25s32.75-12.5 45.25 0L192 306.8l137.4-137.4c12.5-12.5 32.75-12.5 45.25 0s12.5 32.75 0 45.25l-160 160C208.4 380.9 200.2 384 192 384z"></path></svg><!-- <i class="fas fa-angle-down"></i> Font Awesome fontawesome.com --></div>
          </a>
          <div class="collapse" id="collapse#{human_name}" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
            <nav class="sm-hero__sidenav-menu-nested nav">
              <% if namespaced? -%>
                <a class="nav-link" href="<%= #{namespace.underscore}_#{plural_table_name}_path %>">- Lista</a>
                <a class="nav-link" href="<%= new_#{namespace.underscore}_#{singular_table_name}_path %>">- Novo(a)</a>
              <% else %>
                <a class="nav-link" href="<%= #{plural_table_name}_path %>">- Lista</a>
                <a class="nav-link" href="<%= new_#{singular_table_name}_path %>">- Novo(a)</a>
              <% end %>
            </nav>
          </div>
        </li>
      HTML
    end


end
