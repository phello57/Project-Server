
class Sql_init
	def init
		db = SQLite3::Database.new "test.db"

		result = db.execute(
		<<-SQL
			SELECT name 
			FROM sqlite_master 
			WHERE type='table' AND name='users';
		SQL
		)

		if result.empty?
			db.execute "create table users (username VARCHAR(20),password VARCHAR(60))"
			{"phello" => "$2a$12$vctC/fz9ZZJ1QV51YlnGe.YnfHFPL1hJRjDP8adHr6FFFXNTL5gaK"}.each do |pair|
				db.execute "insert into users values ( ?, ? )", pair
			end
		end

		db
	end
end
