class AddTimestamps < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :users, default: Time.zone.now
    change_column_default :users, :created_at, nil
    change_column_default :users, :updated_at, nil

    add_timestamps :visits, default: Time.zone.now
    change_column_default :visits, :created_at, nil
    change_column_default :visits, :updated_at, nil

    add_timestamps :shortened_urls, default: Time.zone.now
    change_column_default :shortened_urls, :created_at, nil
    change_column_default :shortened_urls, :updated_at, nil
  end
end
