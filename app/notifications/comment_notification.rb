# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(post: @post).deliver(current_user)

class CommentNotification < Noticed::Base
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

  # def message
  #   @commentable = params[:comment].commentable
  #   @comment = Comment.find(params[:comment][:id])
  #   @user = User.find(@comment.user_id)
  #   # "#{@user.username} commented on \"#{@commentable.title.truncate(10)}\""
  #   ActionController::Base.new.render_to_string(:partial => 'notification/notifications/comment',
  #                    :layout => false, :locals => {
  #       commentable: @commentable,
  #       comment: @comment,
  #       user: @user
  #     })
  # end

  def url
    params[:comment].commentable
  end
end
