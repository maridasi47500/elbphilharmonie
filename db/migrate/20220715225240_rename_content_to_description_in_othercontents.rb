class RenameContentToDescriptionInOthercontents < ActiveRecord::Migration[6.0]
  def change
    rename_column :othercontents, :content, :textcontent
  end
end
