# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130801182535) do

  create_table "question_answers", :force => true do |t|
    t.string   "answer"
    t.integer  "question_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "question_answers", ["question_id"], :name => "index_question_answers_on_question_id"

  create_table "questionaires", :force => true do |t|
    t.integer  "author_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "questionaires", ["author_id"], :name => "index_questionaires_on_author_id"

  create_table "questions", :force => true do |t|
    t.string   "question"
    t.integer  "questionaire_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "questions", ["questionaire_id"], :name => "index_questions_on_questionaire_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "votes", :force => true do |t|
    t.integer  "question_answer_id"
    t.integer  "voter_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "votes", ["question_answer_id"], :name => "index_votes_on_question_answer_id"
  add_index "votes", ["voter_id"], :name => "index_votes_on_voter_id"

end
