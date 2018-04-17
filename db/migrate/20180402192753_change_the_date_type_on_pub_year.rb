class ChangeTheDateTypeOnPubYear < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :publication_year
  end
end
