db = SQLite3::Database.new('test.db')

{ 'phello' => '$2a$12$vctC/fz9ZZJ1QV51YlnGe.YnfHFPL1hJRjDP8adHr6FFFXNTL5gaK'
}.each do |pair|
	db.execute 'insert into users values ( ?, ? )', pair
end
