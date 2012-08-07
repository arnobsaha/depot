=begin
    This will create 100 orders with no line items in them. Feel free to modify the
script to create line items if you are so inclined. Note that this code does all
this work in one transaction. This isn’t precisely required for this activity but
does speed up the processing.

*** Important : Note that we don’t have any require statements or initialization to open or close
the database. We will allow Rails to take care of this for us

=end
Order.transaction do
  (1..100).each do |i|
    Order.create(:name => "Customer #{i}", :address => "#{i} Main Street",
                 :email => "customer-#{i}@example.com", :pay_type => "Check")
  end
end
