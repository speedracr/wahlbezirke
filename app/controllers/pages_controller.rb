class PagesController < ApplicationController
  before_action :authenticated_user?, except: [:login, :faq]

  def faq
  end

  def login
  end
end
