class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def vote
    
  end

  def veto
  end

  def suggestion
  end



  private

  def set_user
    @user = User.find(params[:id])
  end

end
