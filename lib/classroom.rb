class Classroom
  attr_accessor :teacher, :course, :assignments, :students

  def initialize
    self.teacher = Factory :teacher, :email => 'bob@wa.edu'
    self.course = Factory :course, :teacher => teacher, :start_date => 1.month.ago.to_date, :end_date => 1.month.from_now.to_date
    self.students = enroll_students
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
    FULL_NAMES.map do |full_name| enroll_student(full_name)
      student = Factory :student, :full_name => full_name
      Factory :studier, :student => student, :course => course
      student
    end
  end

  ASSIGNMENT_NAMES = [
    'Memorize Pi',
    'Analyze a Poem',
    'Write a poem',
    'Critique The Old Man and the Sea'
  ]

  def assign_homework
    ASSIGNMENT_NAMES.map do |assignment_name|
      Factory :assignment, :course => course
    end
  end
end