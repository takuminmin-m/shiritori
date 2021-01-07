class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :words, dependent: :nullify
  has_many :room_ownerships, dependent: :destroy
  has_many :rooms, through: :room_ownerships
  has_many :room_memberships, dependent: :destroy

  after_create_commit { GetEveryonesMembershipJob.perform_later self }
end
