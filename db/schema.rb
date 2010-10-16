# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101016174740) do

  create_table "band_genres", :id => false, :force => true do |t|
    t.integer "band_id",  :null => false
    t.integer "genre_id", :null => false
  end

  add_index "band_genres", ["band_id"], :name => "index_band_genres_on_band_id"
  add_index "band_genres", ["genre_id"], :name => "index_band_genres_on_genre_id"

  create_table "band_links", :force => true do |t|
    t.integer "band_id", :null => false
    t.string  "url"
    t.string  "service"
  end

  add_index "band_links", ["band_id"], :name => "index_band_links_on_band_id"

  create_table "bands", :force => true do |t|
    t.string "name",         :null => false
    t.string "city"
    t.string "contact_info"
  end

  add_index "bands", ["city"], :name => "index_bands_on_city"

  create_table "genres", :force => true do |t|
    t.string "name"
  end

  add_index "genres", ["name"], :name => "index_genres_on_name"

end
