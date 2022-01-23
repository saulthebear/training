class RenameColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :commenter_id, :author_id
  end
end
