# frozen_string_literal: true

require './sql/migrate'
require './sql/seed'

class SqlInit
  def init
    db = SQLite3::Database.new('test.db')
    Migrate.new(db)
    Seed.new(db)

    db
  end
end
