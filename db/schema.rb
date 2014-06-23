ActiveRecord::Schema.define(version: 20140623033439) do

  create_table "cards", force: true do |t|
    t.string   "name"
    t.integer  "cost"
    t.string   "kind"
    t.string   "picture"
    t.integer  "stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deckcards", force: true do |t|
    t.integer  "player_id"
    t.integer  "card_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ns", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ns", ["email"], name: "index_ns_on_email", unique: true
  add_index "ns", ["reset_password_token"], name: "index_ns_on_reset_password_token", unique: true

  create_table "players", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
