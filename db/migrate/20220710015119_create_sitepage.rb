class CreateSitepage < ActiveRecord::Migration[6.0]
  def change
    create_table :sitepages do |t|
      t.string :title
      t.string :url
    end
  end
end
