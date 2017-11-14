class AddSubdomainToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :subdomain, :string
  end
end
