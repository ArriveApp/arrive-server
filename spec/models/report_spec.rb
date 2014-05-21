require 'spec_helper'

describe Report do
  let(:hogwarts) { FactoryGirl.create(:school) }
  let(:winterfell) { FactoryGirl.create(:school) }
  let(:dark_magic) { FactoryGirl.create(:course, school: hogwarts) }
  let(:potions_magic) { FactoryGirl.create(:course, school: hogwarts) }
  let(:today) { Time.now.utc }
  let(:day_before_yesterday) { (Time.now-2.day).utc }
  let(:yesterday) { (Time.now - 1.day).utc }
  let(:attrs) { { "type" => type, "from" => from, "to" => to, "course_id" => course_id, "school_id" => hogwarts.id } }

  describe "#populate_results" do
    let(:snape_checkin)    { FactoryGirl.create(:check_in, course: dark_magic, school: hogwarts, created_at: day_before_yesterday) }
    let(:dobby_checkin)    { FactoryGirl.create(:check_in, course: dark_magic, school: hogwarts, created_at: yesterday) }
    let(:hermoine_checkin) { FactoryGirl.create(:check_in, course: potions_magic, school: hogwarts, created_at: yesterday) }
    let(:harry_checkin)    { FactoryGirl.create(:check_in, course: dark_magic, school: hogwarts, created_at: day_before_yesterday) }
    let(:arya_checkin)     { FactoryGirl.create(:check_in, school: winterfell, created_at: day_before_yesterday) }

    let(:from) { day_before_yesterday.strftime('%m-%d-%Y') }
    let(:to) { today.strftime('%m-%d-%Y') }

    before do
      snape_checkin
      harry_checkin
      dobby_checkin
      hermoine_checkin
      arya_checkin
    end

    context "with students who checked in" do
      let(:course_id) { dark_magic.id }
      let(:type) { "students_with_checkins" }

      it "should find the checkins for the dates provided" do
        report = Report.build attrs, hogwarts.id

        report.populate_results

        report.results.should =~ [snape_checkin, harry_checkin, dobby_checkin]
      end

      context "with different dates" do
        let(:from) { yesterday.strftime('%m-%d-%Y')}

        it "should exclude students who have not checked in for the requested dates" do
          report = Report.build attrs, hogwarts.id

          report.populate_results

          report.results.should =~ [dobby_checkin]
        end
      end
    end

    context "without students who checked in" do
      let(:course_id) { potions_magic.id }
      let(:type) { "students_without_checkins" }

      it "should find all the students in that school who have not checked in to the course in the given dates" do
        report = Report.build attrs, hogwarts.id

        report.populate_results

        report.results.should =~ [snape_checkin.user, dobby_checkin.user, harry_checkin.user]
      end
    end
  end
end
