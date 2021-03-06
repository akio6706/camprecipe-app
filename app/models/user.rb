class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, { with: PASSWORD_REGEX, message: 'は半角英数字で入力して下さい。' }
  with_options presence: true do
    validates :password, on: :create
    validates :nickname,  length: { maximum: 40 }
    validates :name,      format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'は名前を入力して下さい。' }
    validates :name_kana, format: { with: /\A[ぁ-んー－]+\z/, message: 'はひらがなで入力して下さい' }
  end

  def update_without_current_password(params, *_options)
    params.delete(:current_password)
    if params[:password].blank? && params[:password_confirmation].blank?

      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *_options)
    clean_up_passwords
    result
  end

  has_many :recipes
  has_many :comments
end
