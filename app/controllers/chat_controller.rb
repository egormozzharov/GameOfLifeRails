class ChatController < WebsocketRails::BaseController
  include ActionView::Helpers::SanitizeHelper

  def initialize_session
    @first_request = true
    puts "Session Initialized\n"
  end

  def system_msg(ev, msg)
    broadcast_message ev, {
        user_name: 'system',
        received: Time.now.to_s(:short),
        msg_body: msg
    }
  end

  def user_msg(ev, msg)
    broadcast_message ev, {
        user_name:  current_user[:email],
        received:   Time.now.to_s(:short),
        msg_body:   ERB::Util.html_escape(msg)
    }
  end

  def client_connected
    system_msg :new_message, "#{current_user[:email]} connected" if @first_request
    @first_request = nil
  end

  def new_message
    user_msg :new_message, message[:msg_body].dup
  end

  def new_user
    connection_store[:user] = { user_name: "#{current_user[:email]}" }
    broadcast_user_list
  end

  def change_username
    connection_store[:user][:user_name] = sanitize(message[:user_name])
    broadcast_user_list
  end

  def delete_user
    connection_store[:user] = nil
    system_msg "client #{current_user[:email]} disconnected"
    broadcast_user_list
  end

  def broadcast_user_list
    users = connection_store.collect_all(:user)
    broadcast_message :user_list, users
  end

end
