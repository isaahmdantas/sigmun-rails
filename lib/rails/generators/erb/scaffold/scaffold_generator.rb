# frozen_string_literal: true

require "rails/generators/erb"
require "rails/generators/resource_helpers"

module Erb # :nodoc:
    module Generators # :nodoc:
        class ScaffoldGenerator < Base # :nodoc:
            include Rails::Generators::ResourceHelpers

            argument :attributes, type: :array, default: [], banner: "field:type field:type"

            def create_root_folder
                empty_directory File.join("app/views", controller_file_path)
            end

            def copy_view_files
                available_views.each do |view|
                    formats.each do |format|
                        filename = filename_with_extensions(view, format)
                        template filename, File.join("app/views", controller_file_path, filename)
                    end
                end

                available_views_turbo.each do |view_turbo|
                    filename_turbo_stream = filename_with_extensions(view_turbo, :turbo_stream)
                    template filename_turbo_stream, File.join("app/views", controller_file_path, filename_turbo_stream)
                end
            end

            private
                def available_views
                    %w(index edit show new _form _form_actions _show_actions _show _datatable _table)
                end

                def available_views_turbo
                    %w(form_update)
                end

        end
    end
end
