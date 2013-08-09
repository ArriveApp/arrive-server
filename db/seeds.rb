# create test school
hogwarts = School.create(name: "Hogwarts");
winterfell = School.create(name: "Winterfell");
nightengale = School.create(name: "Nightengale");

# creating test users
User.create(email: "testuser1@test.com", school_id: hogwarts.id, username: "harrypotter", password:"test", password_confirmation:"test", firstname: "Harry", lastname: "Potter");
User.create(email:"testuser2@test.com", school_id: hogwarts.id, username: "hermione", password:"test", password_confirmation:"test", firstname: "Hermione", lastname: "Granger");
User.create(email:"testuser3@test.com", school_id: hogwarts.id, username: "ronweasley", password:"test", password_confirmation:"test", firstname: "Ron", lastname: "Weasly");

User.create(email:"arya@test.com", school_id: winterfell.id, username: "aryastark", password:"test", password_confirmation:"test", firstname: "Arya", lastname: "Stark");
User.create(email:"ned@test.com", school_id: winterfell.id, username: "nedstark", password:"test", password_confirmation:"test", firstname: "Ned", lastname: "Stark");
User.create(email:"rob@test.com", school_id: winterfell.id, username: "robstark", password:"test", password_confirmation:"test", firstname: "Rob", lastname: "Stark");

User.create(email:"someone@nightengale.edu", school_id: nightengale.id, username: "someone", password:"test", password_confirmation:"test", firstname: "somestudent", lastname: "yes");

User.create(email:"adamleystrnad@gnightingale.org", school_id: nightingale.id, username: "adamleystrnad", password:"1234", password_confirmation:"1234", firstname: "Alexandra", lastname: "Damley-Strnad");
