# To deliver this notification:
#
# LikeNotification.with(post: @post).deliver_later(current_user)
# LikeNotification.with(post: @post).deliver(current_user)

class LikeNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.

  def message
    @likeable = params[:like].likeable
    @like = Like.find(params[:like][:id])
    @user = User.find(@like.user_id)
    { :partial => 'notification/components/like',
      :locals => {
        likeable: @likeable,
        like: @like,
        user: @user
      } }
  end
  
  def url
    params[:like].likeable
  end
end
