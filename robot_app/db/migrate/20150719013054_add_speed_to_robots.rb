class AddSpeedToRobots < ActiveRecord::Migration
  def change
    add_column :robots, :speed, :integer
  end
end
