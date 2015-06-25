class TransfersController < ApplicationController

  def trans_url_b64_param
    s_b64_url = params[:url].to_s;
    s_url = Base64.urlsafe_decode64(s_b64_url).to_s;
    session[:return_url] = s_url;
    redirect_to session[:return_url];
  end

end





