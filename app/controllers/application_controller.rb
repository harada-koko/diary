class ApplicationController < ActionController::Base
  # deviseのコントローラーが使われる前に、configure_permitted_parametersメソッドを実行する
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # 新規登録時(sign_up時)にnameというキーのパラメーターも許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end