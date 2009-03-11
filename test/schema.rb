ActiveRecord::Schema.define :version => 0 do
  create_table :users, :force => true do |t|
    t.string :name, :email
    t.string :username, :hashed_password, :salt
  end
end
