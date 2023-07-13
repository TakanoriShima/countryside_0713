class MessagesController < ApplicationController
  before_action :setup_users, except: :dm_users

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
  
  def dm_users
    # DMのやり取りをしているユーザー一覧
    messages = Message.where(from_id: current_user.id).or(Message.where(to_id: current_user.id))
    puts "ここ一覧"
    p messages
    user_ids = []
    messages.each do |message|
      if message.from_id != current_user.id
        user_ids.append(message.from_id)
      end
      if message.to_id != current_user.id
        user_ids.append(message.to_id)
      end
    end
    p user_ids
    user_ids = user_ids.uniq
    p user_ids
    @users = User.where(id: user_ids)
    p @users
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
