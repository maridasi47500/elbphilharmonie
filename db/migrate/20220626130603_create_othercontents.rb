class CreateOthercontents < ActiveRecord::Migration[6.0]
  def change
    create_table :othercontents do |t|
      t.integer :content_id
      t.text :content
      t.string :type
    end
  end
end
