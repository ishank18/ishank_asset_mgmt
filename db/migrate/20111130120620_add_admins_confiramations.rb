class AddAdminsConfiramations < ActiveRecord::Migration
  def self.up
  	 change_table :admins do |a|
      a.confirmable
    end

    Admin.update_all({:confirmed_at => DateTime.now, :confirmation_token => "Grandfathered Account", :confirmation_sent_at => DateTime.now})

  end

  def self.down
  	 remove_column :users, [:confirmed_at, :confirmation_token, :confirmation_sent_at]
  end
end
