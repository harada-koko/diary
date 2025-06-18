# db/seeds.rb

puts "キャラクターの初期データを作成します..."

# 既に同じ名前のキャラクターが存在する場合は作成しないように、find_or_create_by を使います
Character.find_or_create_by!(name: "いぬ") do |character|
  character.image_url = "inu.png"
  character.cheer_message = "いつも頑張っててえらい！"
end

Character.find_or_create_by!(name: "ねこ") do |character|
  character.image_url = "neko.png"
  character.cheer_message = "その調子！ゆっくりいこうね。"
end

Character.find_or_create_by!(name: "うさぎ") do |character|
  character.image_url = "usagi.png"
  character.cheer_message = "すごい！今日も一日がんばろう！"
end

Character.find_or_create_by!(name: "ぶた") do |character|
  character.image_url = "pig.png"
  character.cheer_message = "ちゃんと記録してえらいね！"
end

Character.find_or_create_by!(name: "ぺんぎん ") do |character|
  character.image_url = "pen.png"
  character.cheer_message = "すごい！なんでもできるね！"
end


puts "キャラクターの初期データの作成が完了しました。"

puts "ユーザーの初期データを作成します..."

User.find_or_create_by!(email: "user1@example.com") do |user|
  user.password = "password"
  user.name = "ユーザー1"
end

User.find_or_create_by!(email: "user2@example.com") do |user|
  user.password = "password"
  user.name = "ユーザー2"
end

User.find_or_create_by!(email: "user3@example.com") do |user|
  user.password = "password"
  user.name = "ユーザー3"
end

puts "ユーザーの初期データの作成が完了しました。"