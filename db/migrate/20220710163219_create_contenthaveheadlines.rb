class CreateContenthaveheadlines < ActiveRecord::Migration[6.0]
  def change
    create_table :contenthaveheadlines do |t|
      t.integer :content_id
      t.integer :headline_id
      t.integer :myorder
    end
    create_table :contenthavelinks do |t|
      t.integer :content_id
      t.integer :link_id
      t.integer :myorder
    end
    create_table :contenthavetexts do |t|
      t.integer :content_id
      t.integer :text_id
      t.integer :myorder
    end
  end
end
