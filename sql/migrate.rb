# frozen_string_literal: true

class Migrate
  def initialize(db)
    db.execute('create table IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, username VARCHAR(20) UNIQUE, password VARCHAR(60))')
  end
end
