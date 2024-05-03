# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_04_21_141954) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dic_job_title", primary_key: "job_title_id", id: :integer, default: nil, force: :cascade do |t|
    t.text "job_title", null: false
    t.index ["job_title"], name: "dic_job_title_job_title_key", unique: true
  end

  create_table "dic_pay_params", id: false, force: :cascade do |t|
    t.integer "id", null: false
    t.text "param_name", null: false
    t.decimal "value", null: false
    t.index ["id"], name: "uniq_dic_pay_params", unique: true
  end

  create_table "dic_sick_rate", id: false, force: :cascade do |t|
    t.integer "id", null: false
    t.integer "min_value", null: false
    t.integer "max_value", null: false
    t.decimal "rate", null: false
    t.index ["id"], name: "uniq_dic_sick_rate", unique: true
  end

  create_table "emp_bonus_data", primary_key: ["emp_id", "order_num"], force: :cascade do |t|
    t.integer "emp_id", null: false
    t.integer "order_num", null: false
    t.date "payment_date", null: false
    t.decimal "amount", precision: 999, scale: 2, null: false
  end

  create_table "emp_jobs_before", id: false, force: :cascade do |t|
    t.integer "emp_id"
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.text "corp_name", null: false
    t.index ["emp_id", "start_date", "end_date"], name: "uniq_emp_jobs_before", unique: true
    t.check_constraint "end_date >= start_date", name: "emp_jobs_before_check"
  end

  create_table "emp_jobs_data", primary_key: ["emp_id", "job_title_id"], force: :cascade do |t|
    t.integer "emp_id", null: false
    t.date "job_start_date", null: false
    t.integer "job_title_id", null: false
    t.index ["emp_id", "job_title_id", "job_start_date"], name: "uniq_emp_jobs_data", unique: true
  end

  create_table "emp_piecework_data", primary_key: ["emp_id", "contract_number"], force: :cascade do |t|
    t.integer "emp_id", null: false
    t.integer "contract_number", null: false
    t.date "contract_date", null: false
    t.date "expiration_date", null: false
    t.decimal "contract_amount", precision: 999, scale: 2, null: false
    t.date "payment_date", null: false
    t.check_constraint "expiration_date > contract_date", name: "emp_piecework_data_check"
  end

  create_table "emp_salary_data", primary_key: ["emp_id", "salary_start_date"], force: :cascade do |t|
    t.integer "emp_id", null: false
    t.date "salary_start_date", null: false
    t.decimal "salary", precision: 9, scale: 2, null: false
    t.index ["emp_id", "salary", "salary_start_date"], name: "uniq_emp_salary_data", unique: true
  end

  create_table "emp_sick_data", primary_key: ["emp_id", "date_start_sick"], force: :cascade do |t|
    t.integer "emp_id", null: false
    t.date "date_start_sick", null: false
    t.date "date_stop_sick", null: false
    t.index ["emp_id", "date_start_sick", "date_stop_sick"], name: "uniq_emp_sick_data", unique: true
    t.check_constraint "date_stop_sick > date_start_sick", name: "emp_sick_data_check"
  end

  create_table "employees", primary_key: "emp_id", id: :integer, default: nil, force: :cascade do |t|
    t.text "last_name", null: false
    t.text "first_name", null: false
    t.text "father_name", null: false
    t.text "snils", null: false
    t.text "tin", null: false
    t.text "passport_sn", null: false
    t.text "passport_num", null: false
    t.date "onboarding_date", null: false
    t.date "leaving_date"
    t.date "insurance_start_date", null: false
    t.text "person_num"
    t.index ["passport_sn", "passport_num"], name: "uniq_passport_sn_passport_num", unique: true
    t.index ["snils"], name: "employees_snils_key", unique: true
    t.index ["tin"], name: "employees_tin_key", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
  end

  create_table "table_2", id: false, force: :cascade do |t|
    t.integer "n"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "emp_bonus_data", "employees", column: "emp_id", primary_key: "emp_id", name: "emp_bonus_data_emp_id_fkey"
  add_foreign_key "emp_jobs_before", "employees", column: "emp_id", primary_key: "emp_id", name: "emp_jobs_before_emp_id_fkey"
  add_foreign_key "emp_jobs_data", "dic_job_title", column: "job_title_id", primary_key: "job_title_id", name: "emp_jobs_data_job_title_id_fkey"
  add_foreign_key "emp_jobs_data", "employees", column: "emp_id", primary_key: "emp_id", name: "emp_jobs_data_emp_id_fkey"
  add_foreign_key "emp_piecework_data", "employees", column: "emp_id", primary_key: "emp_id", name: "emp_piecework_data_emp_id_fkey"
  add_foreign_key "emp_salary_data", "employees", column: "emp_id", primary_key: "emp_id", name: "emp_salary_data_emp_id_fkey"
  add_foreign_key "emp_sick_data", "employees", column: "emp_id", primary_key: "emp_id", name: "emp_sick_data_emp_id_fkey"
  add_foreign_key "roles_users", "roles"
  add_foreign_key "roles_users", "users"
end
