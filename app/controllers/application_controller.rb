class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_found!( opts )
    conf = {
      template: '/404.html', status:   404, layout:   :false
    }.merge( opts )

    if conf[:template]
      render conf
    else
      head :status => 404
    end
  end
end
