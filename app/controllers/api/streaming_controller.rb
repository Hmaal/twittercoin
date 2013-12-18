class Api::StreamingController < ApplicationController
  include ActionController::Live

  def message
    response.headers['Content-Type'] = 'text/event-stream'

    topics = ["coffee", "tea"]

    TWITTER_STREAM.filter(:track => topics.join(",")) do |object|
      if object.is_a?(Twitter::Tweet)
        response.stream.write "#{object.text}\n"
      end
    end

    response.stream.close
  end
end
