class Api::ConfigController < Api::BaseController
  def fullname
    @fullname = APP_CONFIG['fullname']
    if @fullname
      # render :json => {"ok"}, status: 201
      render json: {:status => 200, :text => @fullname}, status: 200
    else
      return api_error(status: 422)
    end
  ensure
    clean_tempfile
  end

  def shortname
    @shortname = APP_CONFIG['shortname']
    if @shortname
      # render :json => {"ok"}, status: 201
      render json: {:status => 200, :text => @shortname}, status: 200
    else
      return api_error(status: 422)
    end
  ensure
    clean_tempfile
  end

  def phone
    @phone = APP_CONFIG['phone']
    if @phone
      # render :json => {"ok"}, status: 201
      render json: {:status => 200, :text => @phone}, status: 200
    else
      return api_error(status: 422)
    end
  ensure
    clean_tempfile
  end

  def email
    @email = APP_CONFIG['email']
    if @email
      # render :json => {"ok"}, status: 201
      render json: {:status => 200, :text => @email}, status: 200
    else
      return api_error(status: 422)
    end
  ensure
    clean_tempfile
  end

  def address
    @address = APP_CONFIG['address']
    if @address
      # render :json => {"ok"}, status: 201
      render json: {:status => 200, :text => @address}, status: 200
    else
      return api_error(status: 422)
    end
  ensure
    clean_tempfile
  end

  def detail
    @detail = APP_CONFIG['detail']
    if @detail
      # render :json => {"ok"}, status: 201
      render json: {:status => 200, :text => @detail}, status: 200
    else
      return api_error(status: 422)
    end
  ensure
    clean_tempfile
  end
end
