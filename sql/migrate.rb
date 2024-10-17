# frozen_string_literal: true

db.execute('create table IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, username VARCHAR(20) UNIQUE, password VARCHAR(60))')

db.execute('create table IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, userid INTEGER UNIQUE, token VARCHAR(300))')
