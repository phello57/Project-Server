# frozen_string_literal: true


class Seed
  def initialize(db)
    [
      ['phello', '$2a$12$vctC/fz9ZZJ1QV51YlnGe.YnfHFPL1hJRjDP8adHr6FFFXNTL5gaK']
    ].each do |arr|
      db.execute('insert OR IGNORE into users (username, password) values ( ?, ? )', [arr[0], arr[1]])
    end
  end
end
