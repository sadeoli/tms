class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  enum access_group: { regular: 0, admin: 5}

  validates :email, format: { with: /[A-Za-z0-9+_.-]+@sistemadefrete.com.br/ }

  def description
    "#{name} - #{email}"
  end

end
