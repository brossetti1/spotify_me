class LinksController < ApplicationController
  def index
  end

  def downvote
    @link = Link.find(params[:id])
    @link.downvote_by current_user
    redirect_to links_path
  end

  def upvote
    @link = Link.find(params[:id])
    @link.upvote_by current_user
    redirect_to links_path
  end

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end
end
