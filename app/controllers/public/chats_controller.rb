class Public::ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]
  # https://qiita.com/OmaeWa000/items/3c3863f0ed5ed25dbc1a　参照
  def create
    @chat = current_member.chats.new(chat_params)
    render :error unless @chat.save
  end

  def show
    @member = Member.find(params[:id])
    # ログインメンバーのroomを全て取得
    rooms = current_member.user_rooms.pluck(:room_id)
    # DMする相手とのroomが存在するか確認
    user_rooms = UserRoom.find_by(member_id: @member.id, room_id: rooms)
    # 存在すればその値を@roomに代入
    unless user_rooms.nil?
      @room = user_rooms.room
    # 存在しなければ新規作成
    else
      @room = Room.new
      @room.save
      # お互いのuserroomを作成　create()はnewとsaveを一緒にできる
      UserRoom.create(member_id: current_member.id, room_id: @room.id)
      UserRoom.create(member_id: @member.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to request.referer
  end

  private

  def chat_params
    params.require(:chat).permit(:chat, :room_id)
  end

  def reject_non_related
    member = Member.find(params[:id])
    # 相互フォローになっているかを確認
    unless current_member.following?(member) && member.following?(current_member)
      redirect_to posts_path
    end
  end
end
