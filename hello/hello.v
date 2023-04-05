module hello

import os { input, user_os }
struct User {
	id   int
	name string
}

struct Repo {
	users []User
}

fn (r Repo) find_user_by_id(id int) !User {
	for user in r.users {
		if user.id == id {
			// V automatically wraps this into a result or option type
			return user
		}
	}
	return error('User ${id} not found')
}

// A version of the function using an option
fn (r Repo) find_user_by_id2(id int) ?User {
	for user in r.users {
		if user.id == id {
			return user
		}
	}
	return none
}


// To export a function we have to use `pub`
pub fn say_hi() {
	println('hello from mymodule!')
	println('Hello World!')
	mut s := r'hello\nworld' // the `\n` will be preserved as two characters
	println(s) // "hello\nworld"
	s = 'hello\nworld' // the `\n` will be preserved as two characters
	println(s) // "hello\nworld"

	// name := input('Enter your name: ')
	// println('Name: ${name}')
	current_os := user_os()
	println('Your OS is ${current_os}.')

	repo := Repo{
		users: [User{1, 'Andrew'}, User{2, 'Bob'}, User{10, 'Charles'}]
	}
	user := repo.find_user_by_id(10) or { // Option/Result types must be handled by `or` blocks
		println(err)
		return
	}
	println(user.id) // "10"
	println(user.name) // "Charles"

	user2 := repo.find_user_by_id2(10) or { return }
	println(user2)
	user3 := repo.find_user_by_id(7) or {
		println(err) // "User 7 not found"
		return
	}
	println(user3)
	user4 := repo.find_user_by_id2(7)
	println(user4)
}