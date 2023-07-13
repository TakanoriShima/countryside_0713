class MessagesController < ApplicationController
  before_action :setup_users

  def index
    @messages = Message.where("from_id IN (:ids) AND to_id IN (:ids)",ids:@ids)
    @message = Message.new
  end


  def create
    @message = current_user.outgoing_messages.build(message_params)
    @message.to_id = params[:id] 
    @message.save
    @messages = Message.where("from_id IN (:ids) AND to_id IN (:ids)",ids:@ids)
    respond_to do |format|
      format.html { redirect_to  messages_url(@to_user)}
      format.js { render "create"}
    end
  end

  private
  def message_params
    params.require(:message).permit(:content)
  end

  def setup_users
    @to_user = User.find(params[:id])
    @ids = [@to_user.id, current_user.id]
    if @to_user.id == current_user.id
      redirect_to root_path
    end  
  end
end
