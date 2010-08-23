class Classroom
  attr_accessor :teacher, :course, :assignments, :studiers

  def initialize
    self.teacher = Factory.teacher.create email: 'bob@wa.edu'
    self.course = Factory.course.create teacher: teacher, start_date: 1.month.ago.to_date, end_date: 1.month.from_now.to_date
    self.studiers = enroll_students
    self.assignments = assign_homework
  end

  FULL_NAMES = [
    'Adam Baum',
    'Adam Zapel',
    'Al Bino',
    'Al Dente',
    'Al Fresco',
    'Al K. Seltzer',
    'Alf A. Romeo',
    'Ali Katt',
    'Amanda Lay',
    'Amanda Lynn',
    'Amber Green',
    'Andy Friese',
    'Anita Bath',
    'Anita Lay',
    'Anna Graham',
    'Anna Prentice',
    'Anna Recksiek',
    'Anna Sasin',
    'Barry Cade',
    'Beau Archer',
    'Ben Dover',
    'Bess Eaton',
    'Biff Wellington',
    'Bill Board',
    'Bill Ding',
    'Bill Foldes',
    'Bill Loney',
    'Carrie Oakey',
    'Casey Macy',
    'Harry Pitts',
    'Dick Trickle'
  ]

  def enroll_students
    FULL_NAMES.map do |full_name|
      student = Factory.student.create full_name: full_name
      Factory.studier.create student: student, course: course
    end
  end

  def assign_homework
    [
      create_assignment('Memorize Pi', 1.week.ago, handed_in_at: 5.days.ago, :graded_at => 3.days.ago),
      create_assignment('Analyze a Poem', 2.days.ago, handed_in_at: 1.day.ago),
      create_assignment('Write a poem', 1.week.ago, hand_in: false),
      create_assignment('Critique Great Gatsby', 3.days.from_now),
      create_assignment('Final Essay', 2.weeks.from_now)
    ]
  end
  
  private
    def create_assignment(name, due_at, composition_attributes = nil)
      assignment = Factory.assignment.create name: name, due_at: due_at, course: course

      if composition_attributes
        composition_attributes.reverse_merge! assignment: assignment
        studiers.each do |studier|
          Factory.composition.create(composition_attributes.reverse_merge(studier: studier))
        end
      end

      assignment
    end

end