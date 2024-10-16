# frozen_string_literal: true

db = SQLite3::Database.new('test.db')

db.execute 'create table users (id INTEGER PRIMARY KEY AUTOINCREMENT, username VARCHAR(20),password VARCHAR(60))'
