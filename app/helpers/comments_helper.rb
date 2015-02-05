module CommentsHelper
  def comment_class_for(comment)
    if comment.comment_type == 'neutral'
      'info'
    elsif comment.comment_type == 'negative'
      'danger'
    else
      'success'
    end
  end
end
