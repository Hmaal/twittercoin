class CriticalError < StandardError
	def initialize(description, details={})
		@pager_client ||= API::PagerDutyMgr::Client.new
		@pager_client.trigger(description, details) if !Rails.env.development?
		super(description)
	end
end
