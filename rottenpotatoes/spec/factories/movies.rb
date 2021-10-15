13 lines (10 sloc)  191 Bytes
   
FactoryBot.define do
  factory :movie do
    title  {'xxx' }
    rating  {'G'}
    release_date {'25-Nov-1993'}
    
    trait :with_director do
        director {'yes'}
    end
    
end

end
