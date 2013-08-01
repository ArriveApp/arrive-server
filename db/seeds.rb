# create test school
hogwarts = School.create(name: "Hogwarts");
winterfell = School.create(name: "Winterfell");

# creating test users
User.create(email:"testuser1@test.com", school_id: hogwarts.id, username: "harrypotter", password:"test", password_confirmation:"test");
User.create(email:"testuser2@test.com", school_id: hogwarts.id, username: "hermione", password:"test", password_confirmation:"test");
User.create(email:"testuser3@test.com", school_id: hogwarts.id, username: "ronweasley", password:"test", password_confirmation:"test");

User.create(email:"arya@test.com", school_id: winterfell.id, username: "aryastark", password:"test", password_confirmation:"test");
User.create(email:"ned@test.com", school_id: winterfell.id, username: "nedstark", password:"test", password_confirmation:"test");
User.create(email:"rob@test.com", school_id: winterfell.id, username: "robstark", password:"test", password_confirmation:"test");
