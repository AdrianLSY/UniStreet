class User < ApplicationRecord
  has_many :qualifications
  has_many :applications
  belongs_to :university, optional: true
  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :first_name, :last_name, :title, :gender, :birthdate, :address, :phone, :nric_passport, :nationality
  enum role: %i[student university_admin sas_admin]
  enum title: %i[mr. ms. mrs.]
  enum gender: %i[male female others]
  enum nationality: %i[local international]

  def credit?(grade)
    if !grade.nil?
      creditGrades = %w[A+ A A- B+ B C+ C]
      if creditGrades.include?(grade.grade)
        return true
      end
      return false
    end
    return false
  end

  def pass?(grade)
    if !grade.nil?
      passGrades = %w[A+ A A- B+ B C+ C D E]
      if passGrades.include?(grade.grade)
        return true
      end
      return false
    end
    return false
  end

  def creditAmount(subjects)
    i = 0
    for subject in subjects
      i += 1 if credit?(subject)
    end
    return i
  end

  def igcseQualifications
    if self.qualifications.any?
      array = []
      for exam in self.qualifications
        if exam.paper.exam == 'IGCSE'
          array.push(exam)
        end
      end
      return creditAmount(array)
    end
    return 0
  end

  def spmQualifications
    bm = Paper.find_by(exam: "SPM", name: "Bahasa Melayu")
    his = Paper.find_by(exam: "SPM", name: "Malaysian History")
    array = []
    if self.qualifications.any?
      if pass?(self.qualifications.find_by_paper_id(bm.id)) && pass?(self.qualifications.find_by_paper_id(his.id))
        for exam in self.qualifications
          if exam.paper.exam == 'SPM'
            array.push(exam)
          end
        end
        return creditAmount(array)
      end
      return 0
    end
    return 0
  end

  def scienceQualifications
    igcse_pass = 0
    igcse_credit = 0
    spm_pass = 0
    spm_credit = 0
    igcse_sciences = [
        Paper.find_by(exam: "IGCSE", name: "Biology"),
        Paper.find_by(exam: "IGCSE", name: "Physics"),
        Paper.find_by(exam: "IGCSE", name: "Chemistry")
    ]
    spm_sciences = [
        spm_bio = Paper.find_by(exam: "SPM", name: "Biology"),
        spm_phy = Paper.find_by(exam: "SPM", name: "Physics"),
        spm_chm = Paper.find_by(exam: "SPM", name: "Chemistry")
    ]
    for sciences in igcse_sciences
      subject  = self.qualifications.find_by(paper_id: sciences.id)
      igcse_pass += 1 if !subject.nil? && pass?(subject)
      igcse_credit += 1 if !subject.nil? && credit?(subject)
    end
    for sciences in spm_sciences
      subject  = self.qualifications.find_by(paper_id: sciences.id)
      spm_pass += 1 if !subject.nil? && pass?(subject)
      spm_credit += 1 if !subject.nil? && credit?(subject)
    end
    return {
        'igcse_pass':igcse_pass,
        'igcse_credit':igcse_credit,
        'spm_pass':spm_pass,
        'spm_credit':spm_credit
    }
  end

  def mathQualification
    igcse_pass = 0
    igcse_credit = 0
    spm_pass = 0
    spm_credit = 0
    igcse_math = [
        Paper.find_by(exam: "IGCSE", name: "Mathematics"),
        Paper.find_by(exam: "IGCSE", name: "Additional Mathematics"),
    ]
    spm_math = [
        Paper.find_by(exam: "SPM", name: "Mathematics"),
        Paper.find_by(exam: "SPM", name: "Additional Mathematics")
    ]
    for math in igcse_math
      subject  = self.qualifications.find_by(paper_id: math.id)
      igcse_pass += 1 if !subject.nil? && pass?(subject)
      igcse_credit += 1 if !subject.nil? && credit?(subject)
    end
    for math in spm_math
      subject  = self.qualifications.find_by(paper_id: math.id)
      spm_pass += 1 if !subject.nil? && pass?(subject)
      spm_credit += 1 if !subject.nil? && credit?(subject)
    end
    return {
        'igcse_pass':igcse_pass > 0,
        'igcse_credit':igcse_credit > 0,
        'spm_pass':spm_pass > 0,
        'spm_credit':spm_credit > 0
    }
  end

  def englishQualification
    igcse_pass = 0
    igcse_credit = 0
    spm_pass = 0
    spm_credit = 0
    igcse_english = [
        Paper.find_by(exam: "IGCSE", name: "English")
    ]
    spm_english = [
        Paper.find_by(exam: "SPM", name: "English")
    ]
    for english in igcse_english
      subject  = self.qualifications.find_by(paper_id: english.id)
      igcse_pass += 1 if !subject.nil? && pass?(subject)
      igcse_credit += 1 if !subject.nil? && credit?(subject)
    end
    for english in spm_english
      subject  = self.qualifications.find_by(paper_id: english.id)
      spm_pass += 1 if !subject.nil? && pass?(subject)
      spm_credit += 1 if !subject.nil? && credit?(subject)
    end
    return {
        'igcse_pass':igcse_pass > 0,
        'igcse_credit':igcse_credit > 0,
        'spm_pass':spm_pass > 0,
        'spm_credit':spm_credit > 0
    }
  end

  def summary
    return {
        'IGCSE':igcseQualifications,
        'SPM':spmQualifications,
        'sciences':scienceQualifications,
        'math':mathQualification,
        'english':englishQualification
    }
  end
end