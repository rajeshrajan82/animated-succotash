class AddUrlToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :url, :string
  end
end
