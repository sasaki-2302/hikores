class Admin::MembersController < ApplicationController
  # 管理者でログインしていなければadminを含むURLにアクセスできないようにする
  before_action :authenticate_admin!

  def index
    @members = Member.all
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    flash[:notice] = "情報を更新"
    redirect_to request.referer
  end

  private
  def member_params
    params.require(:member).permit(:name, :email, :profile_image, :is_deleted)
  end
end
