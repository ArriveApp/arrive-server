require 'spec_helper'

describe User do
  describe '.pins_for_school' do
    it "returns all the pins for the specific school" do
      FactoryGirl.create(:user, pin: '1234', school_id: '1')
      FactoryGirl.create(:user, pin: '5678', school_id: '1')

      FactoryGirl.create(:user, pin: 'abcd', school_id: '2')

      pins = User.pins_for_school('1')

      expect(pins).to eq(['1234', '5678'])
    end
  end

  describe 'needs permission to delete another user' do
    admin = User.new()
    admin.is_admin = true
    admin.id = 1

    another_admin = User.new()
    another_admin.is_admin = true
    another_admin.id = 2


    teacher = User.new()
    teacher.is_teacher = true
    teacher.id = 3

    another_teacher = User.new()
    another_teacher.is_teacher = true
    another_teacher.id = 4

    student = User.new()
    student.is_admin = false
    student.is_teacher = false
    student.id = 5


    it 'can delete any other user if admin' do
        (admin.can_delete teacher).should be_true
        (admin.can_delete another_admin).should be_true
        (admin.can_delete student).should be_true
    end

    it 'admin can not delete self' do
        (admin.can_delete admin).should be_false
    end

    it 'can only remove students if teacher' do

        (teacher.can_delete admin).should be_false
        (teacher.can_delete another_teacher).should be_false
        (teacher.can_delete student).should be_true
    end
  end


end


