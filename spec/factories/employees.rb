FactoryBot.define do
  factory :employee do
    emp_id {100}
    last_name {"David"}
    first_name {"Heinemeier"}
    father_name {"Hansson"}
    snils {12345678901}
    tin {1234567890}
    passport_sn {"6699"}
    passport_num {"999666"}
    onboarding_date {"01.02.2023"}
    leaving_date {nil}
    insurance_start_date {"01.02.2023"}
  end
end