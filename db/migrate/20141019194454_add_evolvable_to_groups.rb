class AddEvolvableToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :evolvable, :boolean, default: false
  end
end
