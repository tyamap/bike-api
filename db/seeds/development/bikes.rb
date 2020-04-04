brands = Brand.all

brands.each do |b|
  2.times do |n|
    @serial_number = "#{b.name}_#{n + 1}"
    b.bikes.create(serial_number: @serial_number)
  end
end
