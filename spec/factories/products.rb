FactoryBot.define do
  factory :product do
    name { "BMX" }
    description { "Unlike regular bikes, like city bikes, BMX bikes boast a distinctive frame geometry. This component features smaller frames, shorter wheelbases, and robust construction. Together, they make up for the model's ability to withstand the rigours of tricks and jumps." }
    association :product_type
  end
end
