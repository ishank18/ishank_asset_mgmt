class AddConfirmationToAdmin < ActiveRecord::Migration

  def self.up
    # add_column :admins, :confirmation_token , :string
    # add_column :admins, :confirmed_at , :datetime
    # add_column :admins, :confirmation_sent_at , :datetime
    # remove_column :admins, :name
  end

  def self.down
    #     remove_column :admins, :confirmation_token
    # remove_column :admins, :confirmed_at
    # remove_column :admins, :confirmation_sent_at
    #     add_column :admins, :name, :string
  end
  
end
