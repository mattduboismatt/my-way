class WelcomeController < ApplicationController
  def index
    if current_user
      current_user.update_multipliers
    end
  end
end
