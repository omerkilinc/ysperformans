# frozen_string_literal: true

class Initial < ActiveRecord::Migration[7.1]
  def change
    create_table(:users) do |t|
      t.string(:name)
      t.string(:username)
      t.string(:password_digest)
      t.timestamps
    end
    User.create(name: "Admin", username: "admin", password: "admin123!", password_confirmation: "admin123!")

    create_table(:standarts) do |t|
      t.string(:name)
      t.text(:description)
      t.timestamps
    end
    Standart.create(name: "isms", description: "ISMS")
    Standart.create(name: "gdpr", description: "GDPR")
    Standart.create(name: "qms", description: "QMS")

    create_table(:business_processes) do |t|
      t.string(:name)
      t.text(:description)
      t.timestamps
    end
    BusinessProcess.create(name: "IT Sureci")
    BusinessProcess.create(name: "Satinalma Sureci")

    create_table(:departments) do |t|
      t.string(:name)
      t.text(:description)
      t.timestamps
    end
    Department.create(name: "IT")
    Department.create(name: "Satinalma")
    Department.create(name: "Muhasebe")
    Department.create(name: "Yonetim")

    create_table(:performance_indicators) do |t|
      t.references(:business_process, foreign_key: true, index: true)
      t.references(:responsible, foreign_key: { to_table: :users }, index: true)
      t.references(:standart, foreign_key: true, index: true)
      t.string(:name)
      t.text(:description)
      t.integer(:indicator_status, default: 2) # (happened, not_happened, not_measured_yet)
      t.integer(:measured_method) # Ölçüm Yöntemi (Manuel/Automatic)
      t.integer(:measurement_criteria) # Ölçüm Yöntemi (TargetDate, Value)
      t.integer(:value_parameter) # Hedef Değer parametresi
      t.date(:targeted_date) # Hedeflenen Tarih
      t.integer(:targeted_value) # Hedeflenen Değer
      t.integer(:last_measured_value)
      t.timestamps
    end

    create_table(:performance_departments, id: false) do |t|
      t.references(:department, foreign_key: true, index: true)
      t.references(:performance_indicator, foreign_key: true, index: true)
    end

    create_table(:performance_measurements) do |t|
      t.references(:performance_indicator, foreign_key: true, index: true)
      t.references(:user, foreign_key: true, index: true)
      t.date(:start_date)
      t.date(:end_date)
      t.date(:target_date)
      t.integer(:measured_value)
      t.date(:measurement_date)
      t.timestamps
    end

  end
end
