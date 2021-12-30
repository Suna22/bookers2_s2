class MailsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @mail = Mail.new
  end

  def create
    @group = Group.find(params[:group_id])
    mail = @group.mails.create(mail_params)
    redirect_to complete_group_mail_path(@group, mail)
  end

  def complete
    @mail = Mail.find(params[:id])
  end

  private
  def mail_params
    params.require(:mail).permit(:title, :content)
  end
end
