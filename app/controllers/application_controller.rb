# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include ApiException
  include ApiResponders

  protect_from_forgery with: :exception
  before_action :set_layout_carrier
  before_action :set_csrf_cookie

  private

    def ensure_current_user_is_superadmin!
      authenticate_user!

      unless current_user.super_admin?
        redirect_to root_path, status: :forbidden, alert: "Unauthorized Access!"
      end
    end

    def set_layout_carrier
      @layout_carrier = LayoutCarrier.new
    end

    def set_csrf_cookie
      cookies["CSRF-TOKEN"] = form_authenticity_token
    end
end
