class RenamePubDateToPubYear < ActiveRecord::Migration[5.1]
  def change
    rename_column :books, :publication_date, :publication_year
  end
end
