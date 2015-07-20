class AddSizeToRobots < ActiveRecord::Migration
  def change
    add_column :robots, :size, :string
  end
end
