
class SqlInit
  def init
    SQLite3::Database.new('test.db')
  end
end
