# -*- coding: utf-8 -*-
class HomeController < ApplicationController
  # 認証されていないと表示されないページ
  before_action :authenticate_user!, only: :show

  def index
  end

  def show
  end
end
