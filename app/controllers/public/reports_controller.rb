class Public::ReportsController < ApplicationController
  before_action :non_self_report, only: [:new]

  def new
    @report = Report.new
    @member = Member.find(params[:member_id])
  end

  def create
    @member = Member.find(params[:member_id])
    @report = Report.new(report_params)
    @report.reporter_id = current_member.id
    @report.reported_id = @member.id
    if @report.save #保存する
      redirect_to member_path(@member), notice: "ご報告ありがとうございました。"
    else
      flash[:error] = "必須項目を入力して下さい。"
      redirect_to new_member_report_path(@member)
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason, :url)
  end

  def non_self_report
    member = Member.find(params[:member_id])
    # 自分の通報ページを表示できないようにする
    if current_member.id == member.id
      flash[:error] = "自分のアカウントを通報することはできません。"
      redirect_to request.referer
    end
  end
end