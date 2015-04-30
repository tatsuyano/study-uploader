# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#

class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  scope :mine, ->(user_id) {where("user_id = ?",user_id)}
end
