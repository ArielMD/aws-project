class ApplicationController < ActionController::API
  before_action :snake_case_params

  def snake_case_params
    request.parameters.deep_transform_keys!(&:underscore)
  end
end
