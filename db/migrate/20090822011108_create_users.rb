class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email,        :null => false
      t.string :access_token, :null => false
      t.boolean :active,      :null => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
