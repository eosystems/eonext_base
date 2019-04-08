class BaseController < ApplicationController
   def request_body
    @body ||= request.body.read
  end

  def json_request_body
    JSON.parse(request_body).with_indifferent_access
  end
end
