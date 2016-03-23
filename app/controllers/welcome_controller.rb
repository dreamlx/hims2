class WelcomeController < ApplicationController
  skip_before_action :logged_in_admin
  def index
    @users_grid = initialize_grid(User,
              :per_page => 5)
    @institutions_grid = initialize_grid(Institution,
              :per_page => 5)
    @individuals_grid = initialize_grid(Individual,
              :per_page => 5)
    @funds_grid = initialize_grid(Fund,
              :per_page => 5)
    @products_grid = initialize_grid(Product,
              :per_page => 5)
  end
end
