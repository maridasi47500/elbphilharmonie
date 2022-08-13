# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_07_17_144441) do

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.string "type"
    t.text "subtitle"
    t.string "shortsubtitle"
    t.string "littlepic"
    t.string "littlepictitle"
    t.string "image"
    t.text "description"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "blogshavecontents", force: :cascade do |t|
    t.integer "blog_id"
    t.integer "content_id"
  end

  create_table "blogshavepictures", force: :cascade do |t|
    t.integer "blog_id"
    t.integer "mypic_id"
  end

  create_table "blogshavetags", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "blog_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "booklets", force: :cascade do |t|
    t.integer "event_id"
    t.string "link"
    t.string "title"
    t.string "size"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "concert_broadcasts", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contenthaveheadlines", force: :cascade do |t|
    t.integer "content_id"
    t.integer "headline_id"
    t.integer "myorder"
  end

  create_table "contenthavelinks", force: :cascade do |t|
    t.integer "content_id"
    t.integer "link_id"
    t.integer "myorder"
  end

  create_table "contenthavetexts", force: :cascade do |t|
    t.integer "content_id"
    t.integer "text_id"
    t.integer "myorder"
  end

  create_table "contents", force: :cascade do |t|
    t.text "content"
    t.integer "myorder"
  end

  create_table "contentshavebloglinks", force: :cascade do |t|
    t.integer "blog_id"
    t.integer "content_id"
  end

  create_table "contentshaveblogs", force: :cascade do |t|
    t.integer "content_id"
    t.integer "blog_id"
  end

  create_table "contentshavepictures", force: :cascade do |t|
    t.integer "mypic_id"
    t.integer "content_id"
    t.integer "range"
  end

  create_table "contentshaveseries", force: :cascade do |t|
    t.integer "content_id"
    t.integer "concert_series_id"
  end

  create_table "contentshavevideos", force: :cascade do |t|
    t.integer "video_id"
    t.integer "content_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "myvalue"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dateandtimes", force: :cascade do |t|
    t.integer "event_id"
    t.date "date"
    t.date "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "event_statuses", force: :cascade do |t|
    t.integer "event_id"
    t.string "type"
    t.string "status"
    t.date "date"
    t.string "website"
    t.text "status_sub"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "eventcats", force: :cascade do |t|
    t.integer "mycat_id"
    t.string "name_en"
    t.string "name_fr"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "eventhavecats", force: :cascade do |t|
    t.integer "event_id"
    t.integer "eventcat_id"
  end

  create_table "eventhavepieces", force: :cascade do |t|
    t.integer "piece_id"
    t.integer "event_id"
  end

  create_table "eventhaveteasers", force: :cascade do |t|
    t.integer "teaser_id"
    t.integer "event_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "venue_id"
    t.string "title"
    t.string "subtitle"
    t.date "date"
    t.time "time"
    t.string "price"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "promoter"
    t.text "description"
    t.integer "elbid"
    t.time "endtime"
    t.integer "subscription_id"
  end

  create_table "eventshaveblogs", force: :cascade do |t|
    t.integer "event_id"
    t.integer "blog_id"
  end

  create_table "eventshavebroadcasts", force: :cascade do |t|
    t.integer "event_id"
    t.integer "concert_broadcast_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "eventshavepromoters", force: :cascade do |t|
    t.integer "event_id"
    t.integer "promoter_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "eventshavespotlights", force: :cascade do |t|
    t.integer "event_id"
    t.integer "spotlight_id"
  end

  create_table "favoriteevents", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  create_table "festivals", force: :cascade do |t|
    t.date "begindate"
    t.date "enddate"
    t.string "title"
    t.text "subtitle"
    t.text "description"
    t.string "image1"
    t.string "image2"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
    t.integer "elbid"
  end

  create_table "festivalshaveblogs", force: :cascade do |t|
    t.integer "festival_id"
    t.integer "blog_id"
  end

  create_table "festivalshaveevents", force: :cascade do |t|
    t.integer "festival_id"
    t.integer "event_id"
  end

  create_table "festivalshavepromoters", force: :cascade do |t|
    t.integer "festival_id"
    t.integer "promoter_id"
  end

  create_table "festivalshavespotifies", force: :cascade do |t|
    t.integer "festival_id"
    t.integer "spotify_id"
  end

  create_table "festivalshavesupportingprogrammes", force: :cascade do |t|
    t.integer "festival_id"
    t.integer "event_id"
  end

  create_table "festivalshavevideos", force: :cascade do |t|
    t.integer "festival_id"
    t.integer "video_id"
  end

  create_table "highlights", force: :cascade do |t|
    t.date "begindate"
    t.date "enddate"
    t.string "title"
    t.string "subtitle"
    t.string "category"
    t.integer "mylabel_id"
    t.string "url"
    t.string "imageurl"
    t.text "content"
    t.string "image"
    t.string "imagecaption"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "links", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "livestreams", force: :cascade do |t|
    t.integer "blog_id"
    t.string "url"
    t.date "begins"
    t.date "ends"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "musical_instruments", force: :cascade do |t|
    t.string "name_en"
    t.string "name_de"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "musicians", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "musical_instrument_id"
  end

  create_table "musicprojects", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.string "image"
    t.string "caption"
    t.string "year"
    t.string "mytype"
    t.date "registerstart"
    t.date "registerend"
    t.date "start"
    t.date "end"
    t.text "description"
    t.integer "event_status_id"
  end

  create_table "musicprojectshaveblogs", force: :cascade do |t|
    t.integer "musicproject_id"
    t.integer "blog_id"
  end

  create_table "musicprojectshaveevents", force: :cascade do |t|
    t.integer "musicproject_id"
    t.integer "events_id"
  end

  create_table "musicprojectshavephotos", force: :cascade do |t|
    t.integer "mypic_id"
    t.integer "musicproject_id"
  end

  create_table "musicprojectshavepromoters", force: :cascade do |t|
    t.integer "promoter_id"
    t.integer "musicproject_id"
  end

  create_table "mycats", force: :cascade do |t|
    t.string "name_en"
    t.string "name_fr"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mylabels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mypics", force: :cascade do |t|
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "newsletters", force: :cascade do |t|
    t.string "name_en"
    t.string "name_de"
    t.string "description_en"
    t.string "description_de"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "newsletterusers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "newsletter_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "othercontents", force: :cascade do |t|
    t.integer "content_id"
    t.text "textcontent"
    t.string "type"
    t.integer "large"
    t.string "image"
  end

  create_table "performers", force: :cascade do |t|
    t.integer "musician_id"
    t.integer "event_id"
  end

  create_table "pics", force: :cascade do |t|
    t.string "type"
    t.integer "venue_id"
    t.string "title"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.integer "event_id"
    t.string "type"
    t.string "title"
    t.string "url"
  end

  create_table "pieces", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "press", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "presshaslinks", force: :cascade do |t|
    t.integer "link_id"
    t.integer "press_id"
  end

  create_table "promoters", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "seasons", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.string "subtitle"
  end

  create_table "sitepages", force: :cascade do |t|
    t.string "title"
    t.string "url"
  end

  create_table "spotifies", force: :cascade do |t|
    t.string "image"
    t.string "iframe"
    t.string "caption"
  end

  create_table "spotifieshavesubscriptions", force: :cascade do |t|
    t.integer "spotify_id"
    t.integer "subscription_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.string "image"
    t.text "description"
    t.date "starts"
    t.date "ends"
    t.integer "elbid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
  end

  create_table "subscriptionshaveevents", force: :cascade do |t|
    t.integer "subscription_id"
    t.integer "event_id"
  end

  create_table "subscriptionshavepromoters", force: :cascade do |t|
    t.integer "subscription_id"
    t.integer "promoter_id"
  end

  create_table "subscriptionshavevideos", force: :cascade do |t|
    t.integer "subscription_id"
    t.integer "video_id"
  end

  create_table "supportingprogrammes", force: :cascade do |t|
    t.integer "event_id"
    t.integer "otherevent_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teasers", force: :cascade do |t|
    t.string "image"
    t.string "subtitle"
    t.string "title"
    t.integer "mylabel_id"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "category"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "street"
    t.string "zip_code"
    t.string "birthday"
    t.string "country"
    t.string "title"
    t.string "gender"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venuehavehalls", force: :cascade do |t|
    t.integer "eventcat_id"
    t.integer "othereventcat_id"
  end

  create_table "venueinfos", force: :cascade do |t|
    t.string "mytype"
    t.integer "venue_id"
    t.text "description_en"
    t.text "description_d"
  end

  create_table "venues", force: :cascade do |t|
    t.string "name_en"
    t.string "name_de"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "locateelb"
    t.text "description"
  end

  create_table "venueshavevenues", force: :cascade do |t|
    t.integer "venue_id"
    t.integer "othervenue_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "overlay"
    t.string "image"
    t.string "caption"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "videoshaveevents", force: :cascade do |t|
    t.integer "video_id"
    t.integer "event_id"
  end

end
