class CreateNewsletters < ActiveRecord::Migration[6.0]
  def change
    create_table :newsletterusers do |t|
      t.integer :user_id
      t.integer :newsletter_id
      t.timestamps
    end
    create_table :newsletters do |t|
      t.string :name_en
      t.string :name_de
      t.string :description_en
      t.string :description_de
      t.timestamps
    end
  end
end
