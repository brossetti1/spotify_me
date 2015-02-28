# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  votes                  :integer          default("5")
#  veto                   :integer          default("1")
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :songs, through: :votes
  has_many :weekly_songs, through: :votes
  has_many :votes


  def process_vote
    if self.can_vote?
      self.vote_count -= 1
      self.save
    end
  end

  def process_veto
    if self.can_veto?
      self.veto_count -= 1
      self.save
    end
  end

  def can_vote?
    self.vote_count > 0
  end

  def can_veto?
    self.veto_count == 1
  end

  def token?
    access_token && !token_expired?
  end
 
  def token_expired?
    Time.now > expires_at
  end
 
  def refresh!
    token_opts = {
      :client_id => ENV["SPOTIFY_CLIENT_ID"],
      :client_secret => ENV["SPOTIFY_CLIENT_SECRET"],
      :grant_type => 'refresh_token',
      :refresh_token => self.refresh_token
    }
    response = HTTParty.post("https://accounts.spotify.com/api/token",
                             :body => token_opts)
    self.update(:access_token => response[:access_token],
                :expires_at => Time.now + response[:expires_in])
  end
 
  def get_token!(auth_code)
    token_opts = {
      :client_id => ENV["SPOTIFY_CLIENT_ID"],
      :client_secret => ENV["SPOTIFY_CLIENT_SECRET"],
      :grant_type => 'authorization_code',
      :code => auth_code,
      :redirect_uri => my_new_token_path(self)
    }
    response = HTTParty.post("https://accounts.spotify.com/api/token",
                             :body => token_opts)
    self.update(:access_token => response[:access_token],
                :refresh_token => response[:refresh_token],
                :expires_at => Time.now + response[:expires_in])
  end

end
