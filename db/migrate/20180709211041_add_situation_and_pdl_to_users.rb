class AddSituationAndPdlToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :situation, :integer
    add_column :users, :pdl, :string
  end
end
