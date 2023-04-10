class AddChatToChat < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :chat, :text
  end
end
