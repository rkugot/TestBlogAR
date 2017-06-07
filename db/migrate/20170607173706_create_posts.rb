class CreatePosts < ActiveRecord::Migration[5.1]
    def change
    	create_table :posts do |t|
    		t.text :name
    		t.text :content
    		t.timestamps
    	end

    	create_table :comments do |t|
    		t.belongs_to :post, index: true
    		t.text :content
    		t.timestamps
    	end
    end
end
