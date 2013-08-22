nightingale = School.create(name: "Nightingale")

# Admin user
User.create(email: "adamleystrnad@nightingale.org", password: "1234", password_confirmation: "1234", pin: '1234', firstname: "Alexandra", lastname: "Damley-Strnad", is_teacher: true, is_admin: true, school_id: nightingale.id)
