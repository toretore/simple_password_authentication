class SimplePasswordAuthenticationGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.migration_template "migration:migration.rb", "db/migrate", :assigns => simple_auth_assigns,
        :migration_file_name => "add_password_authentication_fields_to_#{custom_file_name}" if options[:migration]
    end
  end

private

  def custom_file_name
    custom_name = class_name.underscore.downcase
    custom_name = custom_name.pluralize if ActiveRecord::Base.pluralize_table_names
    custom_name 
  end

  def simple_auth_assigns
    returning({}) do |assigns|
      assigns[:migration_action] = "add"
      assigns[:class_name] = "add_password_authentication_fields_to_#{custom_file_name}"
      assigns[:table_name] = "users"
      assigns[:attributes] = simple_auth_attributes
    end
  end

  def simple_auth_attributes
    returning attributes.dup do |attributes|
      {"username" => "string", "hashed_password" => "string", "salt" => "string"}.each do |name, type|
        attributes << Rails::Generator::GeneratedAttribute.new(name, type) unless attributes.any?{|a| a.name == name }
      end
    end
  end

  def add_options!(opt)
    opt.on('--migration', 'Create migration'){|v| options[:migration] = true }
  end

end
