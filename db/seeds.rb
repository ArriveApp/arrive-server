# create test school
hogwarts = School.create(name: "Hogwarts");
winterfell = School.create(name: "Winterfell");
nightingale = School.create(name: "Nightingale");

# create test courses
Course.create(name: "Defense Against Dark Arts", school_id: hogwarts.id)
Course.create(name: "Potions", school_id: hogwarts.id)
Course.create(name: "Herbology", school_id: hogwarts.id)
Course.create(name: "Archery", school_id: winterfell.id)
Course.create(name: "Wolf Taming", school_id: winterfell.id)
Course.create(name: "History of Night's Watch", school_id: winterfell.id)
Course.create(name: "Calculus", school_id: nightingale.id)
Course.create(name: "French Culture and Civilization", school_id: nightingale.id)
Course.create(name: "Physics", school_id: nightingale.id)

# creating test users
User.create(email: "testuser1@test.com", school_id: hogwarts.id, username: "harrypotter", password: "test", password_confirmation: "test", firstname: "Harry", lastname: "Potter");
User.create(email: "testuser2@test.com", school_id: hogwarts.id, username: "hermione", password: "test", password_confirmation: "test", firstname: "Hermione", lastname: "Granger");
User.create(email: "testuser3@test.com", school_id: hogwarts.id, username: "ronweasley", password: "test", password_confirmation: "test", firstname: "Ron", lastname: "Weasly");

User.create(email: "arya@test.com", school_id: winterfell.id, username: "aryastark", password: "test", password_confirmation: "test", firstname: "Arya", lastname: "Stark");
User.create(email: "ned@test.com", school_id: winterfell.id, username: "nedstark", password: "test", password_confirmation: "test", firstname: "Ned", lastname: "Stark");
User.create(email: "rob@test.com", school_id: winterfell.id, username: "robstark", password: "test", password_confirmation: "test", firstname: "Rob", lastname: "Stark");

User.create(email: "someone@nightingale.edu", school_id: nightingale.id, username: "someone", password: "1234", password_confirmation: "test", firstname: "somestudent", lastname: "yes");

User.create(email: "adamleystrnad@nightingale.org", school_id: nightingale.id, username: "adamleystrnad", password: "1234", password_confirmation: "1234", firstname: "Alexandra", lastname: "Damley-Strnad");
