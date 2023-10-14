class CreateApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :applications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.string :status, null: false, limit: 100, default: "not-seen"
      t.datetime :seen_at
      t.string :resume, limit: 1000

      t.timestamps
    end
  end
end
