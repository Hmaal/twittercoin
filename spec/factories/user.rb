FactoryGirl.define do
  factory :user do
    authenticated true

    factory :mctestor, aliases: [:sender] do
      screen_name 'McTestor'
      api_user_id_str "2253000787"
    end

    factory :jimmy_mctester, aliases: [:recipient] do
      screen_name 'JimmyMcTestor'
      api_user_id_str "2253000787123"
    end

  end

end
