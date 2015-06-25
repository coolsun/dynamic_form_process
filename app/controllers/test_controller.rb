class TestController < ApplicationController

  def test_suntid
    logger.info "X-REMOTE-USER=="
    logger.info "==#{request.headers["X-REMOTE-USER"]}=="
    logger.info "REMOTE_USER=="
    logger.info "==#{request.headers["REMOTE_USER"]}=="
    logger.info "ENV[\"AUTH_TYPE\"]=="
    logger.info "==#{ENV["AUTH_TYPE"]}=="
    logger.info "ENV[\"REMOTE_USER\"]=="
    logger.info "==#{ENV["REMOTE_USER"]}=="
    logger.info "ENV[\"WEBAUTH_AUTHZ_USER\"]=="
    logger.info "==#{ENV["WEBAUTH_AUTHZ_USER"]}=="
    logger.info "ENV[\"WEBAUTH_FACTORS_INITIAL\"]=="
    logger.info "==#{ENV["WEBAUTH_FACTORS_INITIAL"]}=="
    logger.info "ENV[\"WEBAUTH_FACTORS_SESSION\"]=="
    logger.info "==#{ENV["WEBAUTH_FACTORS_SESSION"]}=="
    logger.info "ENV[\"WEBAUTH_LOA\"]=="
    logger.info "==#{ENV["WEBAUTH_LOA"]}=="
    logger.info "ENV[\"WEBAUTH_TOKEN_CREATION\"]=="
    logger.info "==#{ENV["WEBAUTH_TOKEN_CREATION"]}=="
    logger.info "ENV[\"WEBAUTH_TOKEN_EXPIRATION\"]=="
    logger.info "==#{ENV["WEBAUTH_TOKEN_EXPIRATION"]}=="
    logger.info "ENV[\"WEBAUTH_TOKEN_LASTUSED\"]=="
    logger.info "==#{ENV["WEBAUTH_TOKEN_LASTUSED"]}=="
    logger.info "ENV[\"WEBAUTH_USER\"]=="
    logger.info "==#{ENV["WEBAUTH_USER"]}=="
  end

  def index
    render :text => "success"
  end

  def test_email
    StanfordMailer.send_shipped(ADMIN_MAIL, "Email Test", "Email Test #{Time.now()}", [], [])
    redirect_to "/"
  end

end