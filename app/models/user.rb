# -*- coding: utf-8 -*-
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
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string
#  provider               :string
#  uid                    :string
#  image                  :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#

class User < ActiveRecord::Base
  has_many :products, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]

  validates :username, presence: true, uniqueness: true


  def self.from_omniauth(auth)
    # providerとuidでUserレコードを取得する
    # 存在しない場合は、ブロック内のコードを実行して作成する
    #where(auth.slice(:provider, :uid)).first_or_create do |user|
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # auth.provider には "twitter"、
      # auth.uidには twitterアカウントに基づいた個別のIDが入っている
      # first_or_createメソッドが自動でproviderとuidを設定してくれるので、
      # ここでは設定は必要ない
      user.username = auth.info.nickname # twitterで利用している名前が入る
      user.email = auth.info.email # twitterの場合入らない
      user.image = auth.info.image
    end
  end
  
  # Devise の RegistrationsController はリソースを生成する前に self.new_sith_session を呼ぶ
  # つまり、self.new_with_sessionを実装することで、サインアップ前のuserオブジェクトを初期化する
  # ときに session からデータをコピーすることができます。
  # OmniauthCallbacksControllerでsessionに値を設定したので、それをuserオブジェクトにコピーします。
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  # providerがある場合（Twitter経由で認証した）は、passwordは要求しないようにする。
  def password_required?
    super && provider.blank?
  end

  # プロフィールを変更するときによばれる
  def update_with_password(params, *options)
    # パスワードが空の場合、パスワードがなくても更新できる
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
  
end
