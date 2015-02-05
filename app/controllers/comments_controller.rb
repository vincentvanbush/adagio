class CommentsController < ApplicationController
  expose :auction
  expose :comment
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def create
    self.comment = Comment.new(comment_params)
    comment.author = current_user
    comment.user_for = the_other_user
    comment.auction = auction

    if comment.save
      if current_user == auction.winner
        auction.update!(buyer_comment_id: comment.id)
      elsif current_user == auction.user
        auction.update!(seller_comment: comment.id)
      end
      redirect_to user_url(current_user), notice: 'Comment successfully added'
    else
      render 'comments/new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_type, :content, :author_id, :user_for_id, :auction_id)
  end

  def the_other_user
    return auction.winner if auction.user == current_user
    return auction.user if auction.winner == current_user
  end
end
