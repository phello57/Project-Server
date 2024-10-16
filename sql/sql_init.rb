# frozen_string_literal: true

class SqlInit
  def init
    SQLite3::Database.new('test.db')
  end
end
