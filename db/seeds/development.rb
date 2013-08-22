hogwarts = School.create(name: "Hogwarts")
winterfell = School.create(name: "Winterfell")
nightingale = School.create(name: "Nightingale")

Course.create(name: "Defense Against Dark Arts", school_id: hogwarts.id)
Course.create(name: "Potions", school_id: hogwarts.id)
Course.create(name: "Herbology", school_id: hogwarts.id)

Course.create(name: "Wolf Taming", school_id: winterfell.id)
Course.create(name: "History of Night's Watch", school_id: winterfell.id)
Course.create(name: "Archery", school_id: winterfell.id)

# Admin user
User.create(email: "adamleystrnad@nightingale.org", password: "1234", password_confirmation: "1234", pin: '1234', firstname: "Alexandra", lastname: "Damley-Strnad", is_teacher: true, school_id: nightingale.id)

User.create(email: "dumbledore@test.com", password: "test", password_confirmation: "test", pin: 'dumb', firstname: "Albus", lastname: "Dumbledore", is_teacher: true, school_id: hogwarts.id)
User.create(email: "severus@test.com",    password: "test", password_confirmation: "test", pin: 'seve', firstname: "Severus", lastname: "Snape", is_teacher: true, school_id: hogwarts.id)
User.create(email: "harry@test.com",      password: "test", password_confirmation: "test", pin: 'harr', firstname: "Harry", lastname: "Potter", is_teacher: false, school_id: hogwarts.id)
User.create(email: "hermione@test.com",   password: "test", password_confirmation: "test", pin: 'herm', firstname: "Hermione", lastname: "Granger", is_teacher: false, school_id: hogwarts.id)
User.create(email: "ron@test.com",        password: "test", password_confirmation: "test", pin: 'ronw', firstname: "Ron", lastname: "Weasley", is_teacher: false, school_id: hogwarts.id)

User.create(email: "ned@test.com",  password: "test", password_confirmation: "test", pin: 'ned', firstname: "Ned", lastname: "Stark", is_teacher: true, school_id: winterfell.id)
User.create(email: "arya@test.com", password: "test", password_confirmation: "test", pin: 'arya', firstname: "Arya", lastname: "Stark", is_teacher: false, school_id: winterfell.id)
User.create(email: "rob@test.com",  password: "test", password_confirmation: "test", pin: 'rob', firstname: "Rob", lastname: "Stark", is_teacher: false, school_id: winterfell.id)