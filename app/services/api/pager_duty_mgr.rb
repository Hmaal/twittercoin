module API
  module PagerDutyMgr
    module Client
      extend self
      def new
        Pagerduty.new ENV["PAGERDUTY"]
      end
    end

    module CriticalBug
      extend self

      def trigger(description, details={})
        @client ||= API::PagerDutyMgr::Client.new
        @client.trigger(description, details) if !(Rails.env.development? || Rails.env.test?)
      end

    end
  end
end
