# coding: utf-8

(1..20).each do |i|
  u = User.new(name: "test#{i}", email: "test#{i}@example.com")
  u.password = '111111'
  u.save!(validate: false)
end


(1..10).each do 
Relationship.find_or_create_by(follower_id: rand(21), followed_id: rand(21))
end